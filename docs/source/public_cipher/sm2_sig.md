# SM2数字签名

```c
typedef struct {
	uint8_t r[32];
	uint8_t s[32];
} SM2_SIGNATURE;
```

SM2数字签名表示为`SM2_SIGNATURE`结构，包含两个256位整数$(r,s)$。

```c
int sm2_signature_to_der(const SM2_SIGNATURE *sig, uint8_t **out, size_t *outlen);
int sm2_signature_from_der(SM2_SIGNATURE *sig, const uint8_t **in, size_t *inlen);
```

`sm2_signature_to_der`和`sm2_signature_from_der`函数实现SM2签名在`SM2_SIGNATURE`结构和DER格式间的相互转换。

`sm2_signature_to_der`函数执行成功返回1，失败返回-1。`sm2_signature_from_der`函数函数执行成功返回1，失败返回-1，输入签名$(r,s)$中存在长度错误返回-2。

```c
int sm2_do_sign(const SM2_KEY *key, const uint8_t dgst[32], SM2_SIGNATURE *sig);
int sm2_do_verify(const SM2_KEY *key, const uint8_t dgst[32], const SM2_SIGNATURE *sig);
```

在`sm2_do_sign`函数中，SM2密钥`key`应为`SM2_KEY`格式，消息哈希值`dgst`应为256位整数，函数通过这两个参数计算出消息的SM2签名并存放至签名结构`sig`；函数执行成功返回1，失败返回-1。

`sm2_do_verify`函数的参数与此类似，但签名`sig`由调用者提供，并由函数验证其正确性。函数返回非负整数表示验签成功，其中签名正确返回1，签名错误返回0；执行失败返回-1。

```c
int sm2_sign(const SM2_KEY *key, const uint8_t dgst[32], uint8_t *sig, size_t *siglen);
int sm2_verify(const SM2_KEY *key, const uint8_t dgst[32], const uint8_t *sig, size_t siglen);
```

`sm2_sign`函数与`sm2_do_sign`函数类似，但最后计算出的签名被转换为DER格式存放到`sig`中，长度信息存放到`siglen`中。

`sm2_verify`函数与`sm2_do_verify`函数类似，但读取DER格式的签名`sig`和长度信息`siglen`并进行验证。

`sm2_sign`函数执行成功返回1，失败返回-1；`sm2_verify`函数若返回非负数，则与`sm2_do_verify`函数相同，将DER格式签名转换为结构体时失败返回-2，其他步骤执行失败返回-1。

以下函数与SM3哈希函数的使用类似，允许调用者增量添加消息，并在消息全部添加完成后对其进行签名或验签：

```c
typedef struct {
	SM2_KEY key;
	SM3_CTX sm3_ctx;
	int flags;
} SM2_SIGN_CTX;

int sm2_sign_init(SM2_SIGN_CTX *ctx, const SM2_KEY *key, const char *id, size_t idlen);
int sm2_sign_update(SM2_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
int sm2_sign_finish(SM2_SIGN_CTX *ctx, uint8_t *sig, size_t *siglen);

int sm2_verify_init(SM2_SIGN_CTX *ctx, const SM2_KEY *key, const char *id, size_t idlen);
int sm2_verify_update(SM2_SIGN_CTX *ctx, const uint8_t *data, size_t datalen);
int sm2_verify_finish(SM2_SIGN_CTX *ctx, const uint8_t *sig, size_t siglen);
```

`SM2_SIGN_CTX`结构中增加了一个`SM3_CTX`结构，其用法与在SM3哈希函数的用法相同。

`sm2_sign_init`函数的参数包括：

- `SM2_SIGN_CTX`类型的`ctx`，用于存放结果。
- `SM2_KEY`类型的`key`，计算签名使用的密钥。
- 字符串类型的`id`及其整数类型长度的`idlen`，要求长度不超过`SM2_MAX_ID_SIZE`（8191，否则返回失败），用于计算$z$值供哈希函数使用。
- 函数将给定的SM2密钥复制到`ctx`中，并将计算出的$z$值存放到`sm3_ctx`中，等待在其后添加消息。

`sm2_sign_update`函数接收给定的字符串格式消息`data`及其长度`datalen`，并通过`sm3_update`将消息添加到`ctx`中。

`sm2_sign_finish`函数依次调用`sm3_finish`和`sm2_sign`函数来完成签名操作，并将DER格式的签名值存放在`sig`中。

`sm2_verify_init`、`sm2_verify_update`和`sm2_verify_finish`的使用方式与对应签名函数相同。

以上除`sm2_verify_finish`以外的函数执行成功返回1，失败返回-1；`sm2_verify_finish`的返回值与`sm2_verify`相同。
