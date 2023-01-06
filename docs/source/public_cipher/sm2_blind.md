# SM2盲签名

```c
typedef struct {
	SM3_CTX sm3_ctx;
	SM2_KEY public_key;
	uint8_t blind_factor_a[32];
	uint8_t blind_factor_b[32];
	uint8_t sig_r[32];
} SM2_BLIND_SIGN_CTX;
```

SM2盲签名结构`SM2_BLIND_SIGN_CTX`包含：SM3哈希上下文结构`sm3_ctx`、SM2密钥`pblic_key`、两个256位盲因子`blind_factor_a`和`blind_factor_b`和最终的256位盲签名`sig_r`。

```c
int sm2_blind_sign_commit(SM2_Fn k, uint8_t *commit, size_t *commitlen);
```

对随机数k生成承诺值并写入到字节数组`commit`中，长度写入`commitlen`中。函数返回1。

```c
int sm2_blind_sign_init(SM2_BLIND_SIGN_CTX *ctx, const SM2_KEY *public_key, const char *id, size_t idlen);
```

以签名者公钥`public_key`和身份信息`id`（长度`idlen`）作为输入，初始化SM2盲签名将要使用的上下文结构`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_blind_sign_update(SM2_BLIND_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
```

以消息`data`及其长度`datalen`作为输入，更新SM2盲签名上下文结构`ctx`。函数执行成功返回1，失败返回-1。

```c
int sm2_blind_sign_finish(SM2_BLIND_SIGN_CTX *ctx, const uint8_t *commit, size_t commitlen, uint8_t blinded_sig_r[32]);
```

以长度为`commitlen`的承诺值`commit`作为输入，计算盲签名值的r部分并写入到`blinded_sig_r`中。函数执行成功返回1，失败返回-1。

```c
int sm2_blind_sign(const SM2_KEY *key, const SM2_Fn k, const uint8_t blinded_sig_r[32], uint8_t blinded_sig_s[32]);
```

以签名者的密钥`key`和大整数`k`作为输入，计算盲签名值的s部分并写入到`blinded_sig_s`中。函数执行成功返回1，失败返回-1。

```c
int sm2_blind_sign_unblind(SM2_BLIND_SIGN_CTX *ctx, const uint8_t blinded_sig_s[32], uint8_t *sig, size_t *siglen);
```

以盲签名值的s部分`blinded_sig_s`作为输入，计算脱盲后的签名及其长度并分别写入到`sig`与`siglen`中。函数执行成功返回1，失败返回-1。
