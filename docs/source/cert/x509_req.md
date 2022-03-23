# 证书请求

X.509证书请求以如下格式组织：

```c
CertificationRequestInfo ::= SEQUENCE { // 证书请求信息
	version                   INTEGER { v1(0) }, // 版本
	subject                   Name, // 证书主体名称
	subjectPKInfo             SubjectPublicKeyInfo, // 证书公钥
	attributes                [0] IMPLICIT SET OF Attribute
}
CertificationRequest ::= SEQUENCE { // 证书请求
	certificationRequestInfo  CertificationRequestInfo, // 证书请求信息
	signatureAlgorithm        AlgorithmIdentifier, // 证书签名算法标识
	signature                 BIT STRING // 证书签名值
}
```

## 部分接口

本部分头文件中的接口与“X.509证书”部分的接口功能基本一致，但面向对象为证书请求（而非证书），在此不再赘述。

```c
int x509_req_sign(uint8_t *req, size_t *reqlen, size_t maxlen,
	int version,
	const uint8_t *subject, size_t subject_len,
	const SM2_KEY *subject_public_key,
	const uint8_t *attrs, size_t attrs_len,
	int signature_algor,
	const SM2_KEY *sign_key, const char *signer_id, size_t signer_id_len);
```

使用SM2签名算法，对证书请求`req`进行签名。

```c
int x509_req_verify(const uint8_t *req, size_t reqlen,
	const SM2_KEY *sign_pubkey, const char *signer_id, size_t signer_id_len);
```

以签名者的公钥`sign_pubkey`和身份信息`signer_id`验证DER格式证书`req`的SM2签名。

```c
int x509_req_get_details(const uint8_t *req, size_t reqlen,
	int *verison,
	const uint8_t **subject, size_t *subject_len,
	SM2_KEY *subject_public_key,
	const uint8_t **attributes, size_t *attributes_len,
	int *signature_algor,
	const uint8_t **signature, size_t *signature_len);
```

将请求`req`的各项信息存放在指定的数组中。

```c
int x509_req_print(FILE *fp, int fmt, int ind, const char *label, const uint8_t *req, size_t reqlen);
```

调用`vfprintf`等系统函数，打印长为`reqlen`的请求`req`的各项内容到输出流`fp`中。

