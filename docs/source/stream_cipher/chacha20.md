# ChaCha20序列密码

```c
#define CHACHA20_KEY_BITS	256
#define CHACHA20_NONCE_BITS	96
#define CHACHA20_COUNTER_BITS	32

#define CHACHA20_KEY_SIZE	(CHACHA20_KEY_BITS/8)
#define CHACHA20_NONCE_SIZE	(CHACHA20_NONCE_BITS/8)
#define CHACHA20_COUNTER_SIZE	(CHACHA20_COUNTER_BITS/8)

#define CHACHA20_KEY_WORDS	(CHACHA20_KEY_SIZE/sizeof(uint32_t))
#define CHACHA20_NONCE_WORDS	(CHACHA20_NONCE_SIZE/sizeof(uint32_t))
#define CHACHA20_COUNTER_WORDS	(CHACHA20_COUNTER_SIZE/sizeof(uint32_t))
```

定义了ChaCha20算法的密钥长度、随机数长度、计数器长度等信息。

```c
typedef struct {
	uint32_t d[16];
} CHACHA20_STATE;
```

`CHACHA20_STATE`结构包含16个32比特的变量`d`。

```c
void chacha20_init(CHACHA20_STATE *state,
	const uint8_t key[CHACHA20_KEY_SIZE],
	const uint8_t nonce[CHACHA20_NONCE_SIZE], uint32_t counter);
```

以256比特（以大小为32的字节数组表示）的初始密钥`key`、96比特（以大小为12的字节数组表示）的随机数`nonce`和32比特的计数器值`counter`为输入，初始化`CHACHA20_STATE`结构`state`。

```c
void chacha20_generate_keystream(CHACHA20_STATE *state,
	size_t counts, uint8_t *out);
```

以当前的`CHACHA20_STATE`结构`state`为基础，产生`counts`个字节并将其存放到`out`指向的数组中。
