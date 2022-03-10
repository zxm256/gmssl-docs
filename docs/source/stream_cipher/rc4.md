# RC4序列密码

***注意：该密码算法存在安全漏洞，建议不要使用。***

```c
#define RC4_MIN_KEY_BITS	40
#define RC4_STATE_NUM_WORDS	256
```

规定了RC4算法使用的最小密钥长度和算法中的状态数量。

```c
typedef struct {
	unsigned char d[RC4_STATE_NUM_WORDS];
} RC4_STATE;
```

RC4算法状态结构由256个8比特数据组成。

```c
void rc4_init(RC4_STATE *state, const uint8_t *key, size_t keylen);
```

`rc4_init`函数通过给定的密钥数组`key`（长度`keylen`）对RC4状态结构`state`进行初始化。

```c
void rc4_generate_keystream(RC4_STATE *state, size_t outlen, uint8_t *out);
```

`rc4_generate_keystream`函数从当前的RC4状态结构`state`生成长度为`outlen`的密钥流并存放在`out`指向的数组中。
