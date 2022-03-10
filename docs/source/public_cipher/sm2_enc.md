# SM2公钥加密

```c
typedef struct {
	SM2_POINT point;
	uint8_t hash[32];
	uint32_t ciphertext_size;
	uint8_t ciphertext[1];
} SM2_CIPHERTEXT;
```

SM2密文结构包含三部分：椭圆曲线点`point`、256位哈希值`hash`和密文异或值`ciphertext`（及其长度`ciphertext_size`）。

```c
int sm2_ciphertext_to_der(const SM2_CIPHERTEXT *c, uint8_t **out, size_t *outlen);
int sm2_ciphertext_from_der(SM2_CIPHERTEXT *c, const uint8_t **in, size_t *inlen);
```

函数提供SM2密文的格式转换功能。

`sm2_ciphertext_to_der`和`sm2_ciphertext_from_der`函数实现SM2密文在`SM2_CIPHERTEXT`结构和DER格式间的相互转换。函数执行成功返回1，失败返回-1。

```c
int sm2_do_encrypt(const SM2_KEY *key, const uint8_t *in, size_t inlen, SM2_CIPHERTEXT *out);
int sm2_do_decrypt(const SM2_KEY *key, const SM2_CIPHERTEXT *in, uint8_t *out, size_t *outlen);
```

函数提供SM2公钥加解密功能。

在`sm2_do_encrypt`函数中，SM2密钥`key`应为`SM2_KEY`格式，并同时给定明文数组`in`及其长度`inlen`，函数计算出对应密文并存放至密文结构`out`；`sm2_do_decrypt`函数的参数与此类似，但密文`in`由调用者提供，函数对其进行解密并将铭文存放到数组`out`中。函数执行成功返回1，失败返回-1。

```c
int sm2_encrypt(const SM2_KEY *key, const uint8_t *in, size_t inlen, uint8_t *out, size_t *outlen);
int sm2_decrypt(const SM2_KEY *key, const uint8_t *in, size_t inlen, uint8_t *out, size_t *outlen);
```

函数提供提供DER格式的SM2公钥加解密功能。

`sm2_encrypt`函数与`sm2_do_encrypt`函数类似，但最后计算出的密文被转换为DER格式存放到`out`中，长度信息存放到`outlen`中；`sm2_decrypt`函数与`sm2_do_decrypt`函数类似，但读取DER格式的密文`in`和长度信息`inlen`并进行解密，获得的明文及其长度存放到`in`和`inlen`中。函数执行成功返回1，失败返回-1。
