# X.509算法

以下函数针对数字证书中的哈希算法：

```c
const char *x509_digest_algor_name(int oid);
int x509_digest_algor_from_name(const char *name);
int x509_digest_algor_from_der(int *oid, const uint8_t **in, size_t *inlen);
int x509_digest_algor_to_der(int oid, uint8_t **out, size_t *outlen);
```

`x509_digest_algor_name`函数对给定的`oid`值返回对应的哈希算法名称，支持的算法包括SM3, MD5, SHA1, SHA224, SHA256, SHA384, SHA512等。如果`oid`对应的算法不在此列，则返回`NULL`。

`x509_digest_algor_from_name`函数对给定的哈希算法名称返回对应的`oid`枚举值（具体值在`oid.h`中定义），如果给定名称不在此列，则返回值`OID_undef`。

`x509_digest_algor_to_der`函数将给定的哈希算法`oid`转换为DER格式，并按ASN1标准将每一项内容及其长度存放到`out`和`outlen`中；`x509_digest_algor_from_der`则从给定的数组`in`和长度信息`inlen`中读取DER格式私钥并将其写入`oid`中。以上函数执行成功返回1，失败返回-1。



以下函数分别针对数字证书中的对称加密算法、数字签名算法、公钥加密算法、公钥算法，使用方法与哈希算法中对应名称的函数相同：

```c
/* 支持算法包括sm4-cbc、aes128-cbc、aes192-cbc、aes256-cbc */
const char *x509_encryption_algor_name(int oid);
int x509_encryption_algor_from_name(const char *name);
int x509_encryption_algor_from_der(int *oid, const uint8_t **iv, size_t *ivlen, const uint8_t **in, size_t *inlen);
int x509_encryption_algor_to_der(int oid, const uint8_t *iv, size_t ivlen, uint8_t **out, size_t *outlen);

/* 支持算法包括sm2sign-with-sm3、rsasign-with-sm3、ecdsa-with-sha1、ecdsa-with-sha224、ecdsa-with-sha256、ecdsa-with-sha384、ecdsa-with-sha512、sha1WithRSAEncryption、sha224WithRSAEncryption、sha256WithRSAEncryption、sha384WithRSAEncryption、sha512WithRSAEncryption */
const char *x509_signature_algor_name(int oid);
int x509_signature_algor_from_name(const char *name);
int x509_signature_algor_from_der(int *oid, const uint8_t **in, size_t *inlen);
int x509_signature_algor_to_der(int oid, uint8_t **out, size_t *outlen);

/* 支持算法包括sm2encrypt、rsaEncryption、rsaesOAEP */
const char *x509_public_key_encryption_algor_name(int oid);
int x509_public_key_encryption_algor_from_name(const char *name);
int x509_public_key_encryption_algor_from_der(int *oid, const uint8_t **params, size_t *params_len, const uint8_t **in, size_t *inlen);
int x509_public_key_encryption_algor_to_der(int oid, uint8_t **out, size_t *outlen);

/* 支持算法包括ecPublicKey、rsaEncryption */
const char *x509_public_key_algor_name(int oid);
int x509_public_key_algor_from_name(const char *name);
int x509_public_key_algor_from_der(int *oid, const uint8_t **params, size_t *paramslen, const uint8_t **in, size_t *inlen);
int x509_public_key_algor_to_der(int oid, const uint8_t *params, size_t paramslen, uint8_t **out, size_t *outlen);
```

