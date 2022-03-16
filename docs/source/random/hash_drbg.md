# 伪随机数算法

DRBG是指基于哈希函数的确定性随机比特生成器。

```c
/* seedlen for hash_drgb, table 2 of nist sp 800-90a rev.1 */
#define HASH_DRBG_SM3_SEED_BITS		440 /* 55 bytes */
#define HASH_DRBG_SHA1_SEED_BITS	440
#define HASH_DRBG_SHA224_SEED_BITS	440
#define HASH_DRBG_SHA512_224_SEED_BITS	440
#define HASH_DRBG_SHA256_SEED_BITS	440
#define HASH_DRBG_SHA512_256_SEED_BITS	440
#define HASH_DRBG_SHA384_SEED_BITS	888 /* 110 bytes */
#define HASH_DRBG_SHA512_SEED_BITS	888
#define HASH_DRBG_MAX_SEED_BITS		888

#define HASH_DRBG_SM3_SEED_SIZE		(HASH_DRBG_SM3_SEED_BITS/8)
#define HASH_DRBG_SHA1_SEED_SIZE	(HASH_DRBG_SHA1_SEED_BITS/8)
#define HASH_DRBG_SHA224_SEED_SIZE	(HASH_DRBG_SHA224_SEED_BITS/8)
#define HASH_DRBG_SHA512_224_SEED_SIZE	(HASH_DRBG_SHA512_224_SEED_BITS/8)
#define HASH_DRBG_SHA256_SEED_SIZE	(HASH_DRBG_SHA256_SEED_BITS/8)
#define HASH_DRBG_SHA512_256_SEED_SIZE	(HASH_DRBG_SHA512_256_SEED_BITS/8)
#define HASH_DRBG_SHA384_SEED_SIZE	(HASH_DRBG_SHA384_SEED_BITS/8)
#define HASH_DRBG_SHA512_SEED_SIZE	(HASH_DRBG_SHA512_SEED_BITS/8)
#define HASH_DRBG_MAX_SEED_SIZE		(HASH_DRBG_MAX_SEED_BITS/8)

#define HASH_DRBG_RESEED_INTERVAL	((uint64_t)1 << 48)
```

定义了使用各哈希算法时能够产生的最大比特数和字节数，支持SM3和SHA家族算法。

```c
typedef struct {
	const DIGEST *digest;
	uint8_t V[HASH_DRBG_MAX_SEED_SIZE];
	uint8_t C[HASH_DRBG_MAX_SEED_SIZE];
	size_t seedlen;
	uint64_t reseed_counter;
} HASH_DRBG;
```

`HASH_DRBG`结构包含以下成员变量：

- `DIGEST`结构常量`digest`（参见“通用哈希函数接口”部分）；
- 在每次调用DRBG时更新的变量字节数组`V`；
- 由随机种子确定的常量字节数组`C`；
- 上述两个数组的长度`seedlen`；
- 重置随机种子的次数`reseed_counter`。

```c
int hash_drbg_init(HASH_DRBG *drbg,
	const DIGEST *digest,
	const uint8_t *entropy, size_t entropy_len,
	const uint8_t *nonce, size_t nonce_len,
	const uint8_t *personalstr, size_t personalstr_len);
```

初始化`HASH_DRBG`结构`drbg`，需要提供的参数包括：

- `DIGEST`结构常量`digest`（参见“通用哈希函数接口”部分）；
- 常量数组`entropy`及其长度`entropy_len`；
- 常量数组`nonce`及其长度`nonce_len`；
- 常量数组`personalstr`及其长度`personalstr_len`。

```c
int hash_drbg_reseed(HASH_DRBG *drbg,
	const uint8_t *entropy, size_t entropy_len,
	const uint8_t *additional, size_t additional_len);
```

重置`HASH_DRBG`结构`drbg`的种子，需要提供的参数包括：

- 常量数组`entropy`及其长度`entropy_len`；
- 常量数组`additional`及其长度`additional_len`。

```c
int hash_drbg_generate(HASH_DRBG *drbg,
	const uint8_t *additional, size_t additional_len,
	size_t outlen, uint8_t *out);
```

从`HASH_DRBG`结构`drbg`产生长度为`outlen`的随机字节数组`out`，需要提供的参数包括：

- 常量数组`additional`及其长度`additional_len`。

以上函数执行成功返回1，失败返回0。
