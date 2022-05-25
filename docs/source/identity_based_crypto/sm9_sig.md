# SM9数字签名

```c
typedef struct {
	SM9_TWIST_POINT Ppubs;
	sm9_fn_t ks;
} SM9_SIGN_MASTER_KEY;
```

SM9签名主密钥`SM9_SIGN_MASTER_KEY`结构包含两个成员变量，分别为椭圆曲线点形式的主公钥`Ppubs`和大整数形式的主私钥`ks`。

```c
int sm9_sign_master_key_generate(SM9_SIGN_MASTER_KEY *master);
```

主密钥生成函数：随机生成主私钥$ks$，计算对应的主公钥$P_{pubs}$并将二者写入给定的签名主密钥结构`master`中。

函数执行成功返回1，失败返回-1。

```c
int sm9_sign_master_key_extract_key(SM9_SIGN_MASTER_KEY *master, const char *id, size_t idlen, SM9_SIGN_KEY *key);
```

根据给定的用户标识信息字符串`id`及其长度`idlen`，基于给定的签名主密钥`master`计算出用户对应的签名密钥，并写入签名密钥结构`key`中。

函数执行成功返回1，失败返回-1。

```c
int sm9_sign_master_key_info_encrypt_to_der(const SM9_SIGN_MASTER_KEY *msk, const char *pass, uint8_t **out, size_t *outlen);
int sm9_sign_master_key_info_decrypt_from_der(SM9_SIGN_MASTER_KEY *msk, const char *pass, const uint8_t **in, size_t *inlen);
```

实现SM9签名主密钥信息在`SM9_SIGN_MASTER_KEY`结构和加密DER格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_sign_master_key_info_encrypt_to_pem(const SM9_SIGN_MASTER_KEY *msk, const char *pass, FILE *fp);
int sm9_sign_master_key_info_decrypt_from_pem(SM9_SIGN_MASTER_KEY *msk, const char *pass, FILE *fp);
```

实现SM9签名主密钥信息在`SM9_SIGN_MASTER_KEY`结构和加密PEM格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_sign_master_public_key_to_der(const SM9_SIGN_MASTER_KEY *mpk, uint8_t **out, size_t *outlen);
int sm9_sign_master_public_key_from_der(SM9_SIGN_MASTER_KEY *mpk, const uint8_t **in, size_t *inlen);
```

实现SM9签名主公钥在`SM9_SIGN_MASTER_KEY`结构和DER格式文件间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_sign_master_public_key_to_pem(const SM9_SIGN_MASTER_KEY *mpk, FILE *fp);
int sm9_sign_master_public_key_from_pem(SM9_SIGN_MASTER_KEY *mpk, FILE *fp);
```

实现SM9签名主公钥在`SM9_SIGN_MASTER_KEY`结构和PEM格式文件间的相互转换。

函数执行成功返回1，失败返回-1。

```c
typedef struct {
	SM9_TWIST_POINT Ppubs;
	SM9_POINT ds;
} SM9_SIGN_KEY;
```

SM9签名密钥`SM9_SIGN_KEY`结构包含两个成员变量，分别为椭圆曲线点形式的主公钥`Ppubs`和主私钥`ds`。

```c
int sm9_sign_key_info_encrypt_to_der(const SM9_SIGN_KEY *key, const char *pass, uint8_t **out, size_t *outlen);
int sm9_sign_key_info_decrypt_from_der(SM9_SIGN_KEY *key, const char *pass, const uint8_t **in, size_t *inlen);
```

实现SM9签名密钥信息在`SM9_SIGN_KEY`结构和加密DER格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
int sm9_sign_key_info_encrypt_to_pem(const SM9_SIGN_KEY *key, const char *pass, FILE *fp);
int sm9_sign_key_info_decrypt_from_pem(SM9_SIGN_KEY *key, const char *pass, FILE *fp);
```

实现SM9签名密钥信息在`SM9_SIGN_KEY`结构和加密PEM格式存储间的相互转换。

函数执行成功返回1，失败返回-1。

```c
#define SM9_SIGNATURE_SIZE 104
```

规定了SM9签名具有的字节长度。

```c
typedef struct {
	SM3_CTX sm3_ctx;
} SM9_SIGN_CTX;
```

SM9签名上下文结构`SM9_SIGN_CTX`包含了一个SM3上下文结构`sm3_ctx`，用于签名过程中对SM3算法中相关函数的调用。

```c
int sm9_sign_init(SM9_SIGN_CTX *ctx);
```

初始化一个给定的SM9签名上下文结构`ctx`以供后续使用，包括写入签名消息前缀等操作。

函数总是返回1。

```c
int sm9_sign_update(SM9_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
```

向给定的SM9签名上下文结构`ctx`中追加写入长度为`datalen`的消息字节串`data`。

函数总是返回1。

```c
int sm9_sign_finish(SM9_SIGN_CTX *ctx, const SM9_SIGN_KEY *key, uint8_t *sig, size_t *siglen);
```

待签名消息全部写入上下文结构`ctx`后调用，对写入的消息使用给定SM9签名密钥`key`生成签名，并将内容和长度分别存放到字节数组`sig`和整数`siglen`中。

函数执行成功返回1，失败返回-1。

```c
int sm9_verify_init(SM9_SIGN_CTX *ctx);
int sm9_verify_update(SM9_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
```

与`sm9_sign_init`和`sm9_sign_update`函数相同。

```c
int sm9_verify_finish(SM9_SIGN_CTX *ctx, const uint8_t *sig, size_t siglen,
	const SM9_SIGN_MASTER_KEY *mpk, const char *id, size_t idlen);
```

待签名消息全部写入上下文结构`ctx`后调用，对写入的消息、长度为`siglen`的签名`sig`和长度为`idlen`的签名者个人标识字符串`id`使用给定SM9签名主密钥`mpk`进行验签。

函数执行成功返回验签结果，正确为1，错误为0；失败返回-1。
