# ZUC祖冲之序列密码

## ZUC算法

```c
# define ZUC_KEY_SIZE	16
# define ZUC_IV_SIZE	16
# define ZUC_MAC_SIZE	4
```

定义了ZUC算法的密钥长度、初始向量长度、MAC长度等信息。

```c
typedef uint32_t ZUC_BIT;
typedef uint32_t ZUC_UINT5;
typedef uint8_t  ZUC_UINT6;
typedef uint32_t ZUC_UINT15;
typedef uint32_t ZUC_UINT31;
typedef uint32_t ZUC_UINT32;
```

定义了ZUC算法中使用的变量数据结构大小。

```c
typedef struct {
	ZUC_UINT31 LFSR[16];
	ZUC_UINT32 R1;
	ZUC_UINT32 R2;
} ZUC_STATE;
```

`ZUC_STATE`结构包含16个31比特的线性反馈移位寄存器寄存器变量`LFSR`，以及非线性函数的2个32比特记忆单元变量`R1`和`R2`。

```c
void zuc_init(ZUC_STATE *state, const uint8_t key[ZUC_KEY_SIZE], const uint8_t iv[ZUC_IV_SIZE]);
```

以128比特（以大小为16的字节数组表示）的初始密钥`key`和128比特（同上）的初始向量`iv`为输入，初始化`ZUC_STATE`结构`state`（即执行密钥装入、置`R1`和`R2`为全0并运行初始化算法）。

```c
void zuc_generate_keystream(ZUC_STATE *state, size_t nwords, ZUC_UINT32 *words);
```

以当前的`ZUC_STATE`结构`state`为基础，产生`nwords`个`ZUC_UINT32`类型的值并将其存放到`words`指向的数组中。

```c
ZUC_UINT32 zuc_generate_keyword(ZUC_STATE *state);
```

以当前的`ZUC_STATE`结构`state`为基础，产生1个`ZUC_UINT32`类型的值并返回该值。

## ZUC MAC

```c
typedef struct ZUC_MAC_CTX_st {
	ZUC_UINT31 LFSR[16];
	ZUC_UINT32 R1;
	ZUC_UINT32 R2;
	ZUC_UINT32 T;
	ZUC_UINT32 K0;
	uint8_t buf[4];
	size_t buflen;
} ZUC_MAC_CTX;
```

`ZUC_MAC_CTX`结构包含16个31比特的线性反馈移位寄存器寄存器变量`LFSR`、非线性函数的2个32比特记忆单元变量`R1`和`R2`、32比特字变量`T`和`K0`、计数器字节数组`buf`和整数`buflen`。

```c
void zuc_mac_init(ZUC_MAC_CTX *ctx, const uint8_t key[ZUC_KEY_SIZE], const uint8_t iv[ZUC_IV_SIZE]);
```

以128比特（以大小为16的字节数组表示）的初始密钥`key`和128比特（同上）的初始向量`iv`为输入，初始化`ZUC_MAC_CTX`结构`ctx`。

```c
void zuc_mac_update(ZUC_MAC_CTX *ctx, const uint8_t *data, size_t len);
```

用长度为`len`的字节数组`data`更新`ZUC_MAC_CTX`结构`ctx`。

```c
void zuc_mac_finish(ZUC_MAC_CTX *ctx, const uint8_t *data, size_t nbits, uint8_t mac[ZUC_MAC_SIZE]);
```

用长度为`nbits`的字节数组`data`更新`ZUC_MAC_CTX`结构`ctx`，并输出使用ZUC完整性算法计算出的32比特消息认证码，将其存放到数组`mac`中。

## ZUC-EEA

```c
void zuc_eea_encrypt(const ZUC_UINT32 *in, ZUC_UINT32 *out, size_t nbits,
	const uint8_t key[ZUC_KEY_SIZE], ZUC_UINT32 count, ZUC_UINT5 bearer,
	ZUC_BIT direction);
```

使用ZUC机密性算法对长度为`nbits`的输入明文`in`进行加密，并将结果存放到数组`out`中。其他需要提供的参数包括：128比特（以大小为16的字节数组表示）的初始密钥`key`、计数器`count`、承载层标识`bearer`和传输方向标识`direction`。

## ZUC-EIA

```c
ZUC_UINT32 zuc_eia_generate_mac(const ZUC_UINT32 *data, size_t nbits,
	const uint8_t key[ZUC_KEY_SIZE], ZUC_UINT32 count, ZUC_UINT5 bearer,
	ZUC_BIT direction);
```

使用ZUC完整性算法对长度为`nbits`的输入数据`data`计算消息认证码并输出。其他需要提供的参数包括：128比特（以大小为16的字节数组表示）的初始密钥`key`、计数器`count`、承载层标识`bearer`和传输方向标识`direction`。
