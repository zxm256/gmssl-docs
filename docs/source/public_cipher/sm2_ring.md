# SM2环签名

```c
typedef struct {
	int state;
	SM3_CTX sm3_ctx;
	SM2_KEY sign_key;
	SM2_POINT public_keys[SM2_RING_SIGN_MAX_SIGNERS];
	size_t public_keys_count;
	char *id;
	size_t idlen;
} SM2_RING_SIGN_CTX;
```

SM2环签名结构`SM2_RING_SIGN_CTX`包含：状态`state`、SM3哈希上下文结构`sm3_ctx`、签名发起者的SM2密钥`sign_key`、数量为`public_keys_count`的环成员公钥数组`public_keys`和长度为`idlen`的身份信息`id`。

```c
int sm2_ring_do_sign(const SM2_KEY *sign_key, const SM2_POINT *public_keys, size_t public_keys_cnt, const uint8_t dgst[32], uint8_t r[32], sm2_bn_t *s);

int sm2_ring_sign(const SM2_KEY *sign_key, const SM2_POINT *public_keys, size_t public_keys_cnt, const uint8_t dgst[32], uint8_t *sig, size_t *siglen);
```

`sm2_ring_do_sign`以签名发起者的SM2密钥`sign_key`、数量为`public_keys_cnt`的环成员公钥数组`public_keys`和待签名消息的哈希值`dgst`作为输入，生成环签名(r, s)。

`sm2_ring_sign`功能相同，但生成DER格式的字节签名`sig`。

函数执行成功返回1，失败返回-1。

```c
int sm2_ring_do_verify(const SM2_POINT *public_keys, size_t public_keys_cnt, const uint8_t dgst[32], const uint8_t r[32], const sm2_bn_t *s);
int sm2_ring_verify(const SM2_POINT *public_keys, size_t public_keys_cnt, const uint8_t dgst[32], const uint8_t *sig, size_t siglen);
```

`sm2_ring_do_verify`以数量为`public_keys_cnt`的环成员公钥数组`public_keys`、待签名消息的哈希值`dgst`和环签名(r, s)作为输入，进行签名验证：通过返回1，不通过返回0。

`sm2_ring_sign`功能相同，但接受DER格式的字节签名`sig`作为签名输入。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_signature_to_der(const sm2_bn_t r, const sm2_bn_t *s, size_t s_cnt, uint8_t **out, size_t *outlen);
int sm2_ring_signature_from_der(sm2_bn_t r, sm2_bn_t *s, size_t *s_cnt, const uint8_t **in, size_t *inlen);
```

实现SM2环签名信息在(r, s)结构和DER格式储间的相互转换。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_sign_init(SM2_RING_SIGN_CTX *ctx, const SM2_KEY *sign_key, const char *id, size_t idlen);
```

以签名发起者的SM2密钥`sign_key`和长度为`idlen`的身份信息`id`初始化一个SM2环签名结构`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_sign_add_signer(SM2_RING_SIGN_CTX *ctx, const SM2_KEY *public_key);
```

增加公钥为`public_key`的环成员至`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_sign_update(SM2_RING_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
```

以消息`data`及其长度`datalen`作为输入，更新SM2环签名结构`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_sign_finish(SM2_RING_SIGN_CTX *ctx, uint8_t *sig, size_t *siglen);
```

由SM2环签名结构`ctx`生成最终的环签名`sig`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_verify_init(SM2_RING_SIGN_CTX *ctx, const char *id, size_t idlen);
```

以长度为`idlen`的身份信息`id`初始化一个SM2环签名验签结构`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_verify_add_signer(SM2_RING_SIGN_CTX *ctx, const SM2_KEY *public_key);
```

增加公钥为`public_key`的环成员至`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_verify_update(SM2_RING_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
```

以消息`data`及其长度`datalen`作为输入，更新SM2环签名验签结构`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_ring_verify_finish(SM2_RING_SIGN_CTX *ctx, uint8_t *sig, size_t siglen);
```

由SM2环签名验签结构`ctx`对对环签名`sig`进行验签。函数执行成功返回1，失败返回-1。
