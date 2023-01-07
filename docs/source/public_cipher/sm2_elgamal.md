# SM2加法同态加密

```c
typedef struct {
  SM2_POINT C1;
  SM2_POINT C2;
} SM2_ELGAMAL_CIPHERTEXT;
```

SM2同态加密密文结构`SM2_ELGAMAL_CIPHERTEXT`包含两个椭圆曲线点`C1`和`C2`。

```c
int sm2_elgamal_do_encrypt(const SM2_KEY *pub_key, uint32_t in, SM2_ELGAMAL_CIPHERTEXT *out);
```

以SM2公钥`pub_key`和明文`in`作为输入，计算同态密文`out`。函数执行成功返回1，失败返回-1。

```c
int sm2_elgamal_do_decrypt(const SM2_KEY *key, const SM2_ELGAMAL_CIPHERTEXT *in, uint32_t *out);
```

以SM2密钥`key`和同态密文`in`作为输入，解密出明文`out`。函数执行成功返回1，失败返回-1。

```c
int sm2_elgamal_ciphertext_add(SM2_ELGAMAL_CIPHERTEXT *r, const SM2_ELGAMAL_CIPHERTEXT *a, const SM2_ELGAMAL_CIPHERTEXT *b, const SM2_KEY *pub_key);
int sm2_elgamal_cipehrtext_sub(SM2_ELGAMAL_CIPHERTEXT *r, const SM2_ELGAMAL_CIPHERTEXT *a, const SM2_ELGAMAL_CIPHERTEXT *b, const SM2_KEY *pub_key);
int sm2_elgamal_cipehrtext_neg(SM2_ELGAMAL_CIPHERTEXT *r, const SM2_ELGAMAL_CIPHERTEXT *a, const SM2_KEY *pub_key);
```

以SM2同态密文`a`、`b`（如果有）和SM2公钥`pub_key`作为输入，实现SM2同态密文的同态加、减、取负运算，并将结果写入SM2同态密文结构`r`中。函数执行成功返回1，失败返回-1。

```c
int sm2_elgamal_ciphertext_scalar_mul(SM2_ELGAMAL_CIPHERTEXT *R, const uint8_t scalar[32], const SM2_ELGAMAL_CIPHERTEXT *A, const SM2_KEY *pub_key);
```

以SM2同态密文`A`、大整数`scalar`和SM2公钥`pub_key`作为输入，实现SM2同态密文的同态标量乘法运算，并将结果写入SM2同态密文结构`R`中。函数执行成功返回1，失败返回-1。

```c
int sm2_elgamal_ciphertext_to_der(const SM2_ELGAMAL_CIPHERTEXT *c, uint8_t **out, size_t *outlen);
int sm2_elgamal_ciphertext_from_der(SM2_ELGAMAL_CIPHERTEXT *c, const uint8_t **in, size_t *inlen);
```

实现SM2同态密文信息在`SM2_ELGAMAL_CIPHERTEXT`结构和DER格式间的相互转换。函数执行成功返回1，失败返回-1。

```c
int sm2_elgamal_encrypt(const SM2_KEY *pub_key, uint32_t in, uint8_t *out, size_t *outlen);
int sm2_elgamal_decrypt(SM2_KEY *key, const uint8_t *in, size_t inlen, uint32_t *out);
```

与`sm2_elgamal_do_encrypt`和`sm2_elgamal_do_decrypt`功能相同，但SM2同态密文以DER格式的字节及其长度表示。函数执行成功返回1，失败返回-1。
