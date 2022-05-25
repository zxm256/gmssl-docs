# SM9公钥加解密

```c
typedef struct {
	SM9_POINT Ppube;
	sm9_fn_t ke;
} SM9_ENC_MASTER_KEY;
```

SM9加密主密钥`SM9_ENC_MASTER_KEY`结构包含两个成员变量，分别为椭圆曲线点形式的主公钥`Ppube`和大整数形式的主私钥`ke`。

```c
int sm9_enc_master_key_generate(SM9_ENC_MASTER_KEY *master);
```

加密主密钥生成函数：随机生成主私钥`ke`，计算对应的主公钥`Ppube`并将二者写入给定的加密主密钥结构`master`中。

函数执行成功返回1，失败返回-1。

```c
int sm9_enc_master_key_extract_key(SM9_ENC_MASTER_KEY *master, const char *id, size_t idlen, SM9_ENC_KEY *key);
```

根据给定的用户标识信息字符串`id`及其长度`idlen`，基于给定的加密主密钥`master`计算出用户对应的加密密钥，并写入加密密钥结构`key`中。

函数执行成功返回1，失败返回-1。

```c
int sm9_enc_master_key_info_encrypt_to_der(const SM9_ENC_MASTER_KEY *msk, const char *pass, uint8_t **out, size_t *outlen);
int sm9_enc_master_key_info_decrypt_from_der(SM9_ENC_MASTER_KEY *msk, const char *pass, const uint8_t **in, size_t *inlen);
```

实现SM9加密主密钥信息在`SM9_ENC_MASTER_KEY`结构和加密DER格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_enc_master_key_info_encrypt_to_pem(const SM9_ENC_MASTER_KEY *msk, const char *pass, FILE *fp);
int sm9_enc_master_key_info_decrypt_from_pem(SM9_ENC_MASTER_KEY *msk, const char *pass, FILE *fp);
```

实现SM9加密主密钥信息在`SM9_ENC_MASTER_KEY`结构和加密PEM格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_enc_master_public_key_to_der(const SM9_ENC_MASTER_KEY *mpk, uint8_t **out, size_t *outlen);
int sm9_enc_master_public_key_from_der(SM9_ENC_MASTER_KEY *mpk, const uint8_t **in, size_t *inlen);
```

实现SM9加密主公钥在`SM9_ENC_MASTER_KEY`结构和DER格式文件间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_enc_master_public_key_to_pem(const SM9_ENC_MASTER_KEY *mpk, FILE *fp);
int sm9_enc_master_public_key_from_pem(SM9_ENC_MASTER_KEY *mpk, FILE *fp);
```

实现SM9加密主公钥在`SM9_ENC_MASTER_KEY`结构和PEM格式文件间的相互转换。

函数执行成功返回1，失败返回-1。

```c
typedef struct {
	SM9_POINT Ppube;
	SM9_TWIST_POINT de;
} SM9_ENC_KEY;
```

SM9加密密钥`SM9_ENC_KEY`结构包含两个成员变量，分别为椭圆曲线点形式的主公钥`Ppube`和主私钥`de`。

```c
int sm9_enc_key_info_encrypt_to_der(const SM9_ENC_KEY *key, const char *pass, uint8_t **out, size_t *outlen);
int sm9_enc_key_info_decrypt_from_der(SM9_ENC_KEY *key, const char *pass, const uint8_t **in, size_t *inlen);
```

实现SM9加密密钥信息在`SM9_ENC_KEY`结构和加密DER格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_enc_key_info_encrypt_to_pem(const SM9_ENC_KEY *key, const char *pass, FILE *fp);
int sm9_enc_key_info_decrypt_from_pem(SM9_ENC_KEY *key, const char *pass, FILE *fp);
```

实现SM9加密密钥信息在`SM9_ENC_KEY`结构和加密PEM格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
#define SM9_MAX_PLAINTEXT_SIZE 255
#define SM9_MAX_CIPHERTEXT_SIZE 367
```

定义了SM9公钥加解密的明密文最长字节数。

```c
int sm9_encrypt(const SM9_ENC_MASTER_KEY *mpk, const char *id, size_t idlen,
	const uint8_t *in, size_t inlen, uint8_t *out, size_t *outlen);
```

使用给定的SM9加密主密钥`mpk`和长度为`idlen`的用户身份标识字符串`id`，对给定的长度为`inlen`的字节串消息`in`进行加密。密文的内容和长度分别存放至字节数组`out`和整数`outlen`中。

函数执行成功返回1，失败返回-1。

```c
int sm9_decrypt(const SM9_ENC_KEY *key, const char *id, size_t idlen,
	const uint8_t *in, size_t inlen, uint8_t *out, size_t *outlen);
```

使用给定的SM9加密密钥`key`和长度为`idlen`的用户身份标识字符串`id`，对给定的长度为`inlen`的字节串密文`in`进行解密。解密出明文的内容和长度分别存放至字节数组`out`和整数`outlen`中。

函数执行成功返回1，失败返回-1。
