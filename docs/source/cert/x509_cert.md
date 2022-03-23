# X.509证书

X.509证书以如下格式组织：

```c
Certificate ::= SEQUENCE {
	tbsCertificate			TBSCertificate, // 证书主体
	signatureAlgorithm		AlgorithmIdentifier, // 证书签名算法标识
	signatureValue			BIT STRING // 证书签名值,是使用signatureAlgorithm部分指定的签名算法对tbsCertificate证书主题部分签名后的值
}
TBSCertificate ::= SEQUENCE {
	version					[0] EXPLICIT Version DEFAULT v1, // 证书版本号
	serialNumber			CertificateSerialNumber, // 证书序列号
	signature				AlgorithmIdentifier, // 证书签名算法标识
	issuer					Name, // 证书发行者名称
	validity				Validity, // 证书有效期
	subject					Name, // 证书主体名称
	subjectPublicKeyInfo	SubjectPublicKeyInfo, // 证书公钥
	issuerUniqueID			[1] IMPLICIT UniqueIdentifier OPTIONAL, // 证书发行者ID（可选），只在证书版本2、3中才有
	subjectUniqueID			[2] IMPLICIT UniqueIdentifier OPTIONAL, // 证书主体ID（可选），只在证书版本2、3中才有
	extensions				[3] EXPLICIT Extensions OPTIONAL // 证书扩展段（可选），只在证书版本3中才有
}
Version ::= INTEGER { v1(0), v2(1), v3(2) }
CertificateSerialNumber ::= INTEGER
AlgorithmIdentifier ::= SEQUENCE {
	algorithm		OBJECT IDENTIFIER,
	parameters		ANY DEFINED BY algorithm OPTIONAL
}

Name ::= CHOICE {
	RDNSequence
}
RDNSequence ::= SEQUENCE OF RelativeDistinguishedName
RelativeDistinguishedName ::=
	SET OF AttributeTypeAndValue
AttributeTypeAndValue ::= SEQUENCE {
	type	AttributeType,
	value	AttributeValue
}
AttributeType ::= OBJECT IDENTIFIER
AttributeValue ::= ANY DEFINED BY AttributeType
 
Validity ::= SEQUENCE {
	notBefore	Time, // 证书有效期起始时间
	notAfter	Time // 证书有效期终止时间
}
Time ::= CHOICE {
	utcTime			UTCTime, // 以UTC格式表示时间
	generalTime 	GeneralizedTime // 以通用时间格式表示时间
}
UniqueIdentifier ::= BIT STRING
SubjectPublicKeyInfo ::= SEQUENCE {
	algorithm			AlgorithmIdentifier, // 公钥算法
	subjectPublicKey	BIT STRING // 公钥值
// algorithm.algorithm = OID_ec_public_key;
// algorithm.parameters = OID_sm2;
// subjectPublicKey = ECPoint
}

Extensions ::= SEQUENCE SIZE (1..MAX) OF Extension // 证书扩展，见“证书扩展”部分文档
Extension ::= SEQUENCE {
	extnID		OBJECT IDENTIFIER,
	critical	BOOLEAN DEFAULT FALSE,
	extnValue	OCTET STRING
}
```

## 部分接口

```c
int x509_cert_sign(
	uint8_t *cert, size_t *certlen, size_t maxlen,
	int version,
	const uint8_t *serial, size_t serial_len,
	int signature_algor,
	const uint8_t *issuer, size_t issuer_len,
	time_t not_before, time_t not_after,
	const uint8_t *subject, size_t subject_len,
	const SM2_KEY *subject_public_key,
	const uint8_t *issuer_unique_id, size_t issuer_unique_id_len,
	const uint8_t *subject_unique_id, size_t subject_unique_id_len,
	const uint8_t *exts, size_t exts_len,
	const SM2_KEY *sign_key,
	const char *signer_id, size_t signer_id_len);
```

使用SM2签名算法，对待签名证书进行签名。函数的前三个参数用于保存最终生成整数的内容和长度信息，后三个参数为签名方信息，其余参数与X.509证书的各项参数一一对应。

```c
int x509_cert_verify(const uint8_t *a, size_t alen, const SM2_KEY *pub_key, const char *signer_id, size_t signer_id_len);
```

以签名者的公钥`pub_key`和身份信息`signer_id`验证DER格式证书`a`的SM2签名。

```c
int x509_cert_verify_by_ca_cert(const uint8_t *a, size_t alen, const uint8_t *cacert, size_t cacertlen, const char *signer_id, size_t signer_id_len);
```

通过CA证书`cacert`和身份信息`signer_id`验证DER格式证书`a`的SM2签名。

```c
int x509_cert_get_details(const uint8_t *a, size_t alen,
	int *version,
	const uint8_t **serial_number, size_t *serial_number_len,
	int *inner_signature_algor,
	const uint8_t **issuer, size_t *issuer_len,
	time_t *not_before, time_t *not_after,
	const uint8_t **subject, size_t *subject_len,
	SM2_KEY *subject_public_key,
	const uint8_t **issuer_unique_id, size_t *issuer_unique_id_len,
	const uint8_t **subject_unique_id, size_t *subject_unique_id_len,
	const uint8_t **extensions, size_t *extensions_len,
	int *signature_algor,
	const uint8_t **signature, size_t *signature_len);
```

将证书`a`的各项信息存放在指定的数组中。

```c
int x509_certs_print(FILE *fp, int fmt, int ind, const char *label, const uint8_t *d, size_t dlen);
```

调用`vfprintf`等系统函数，打印长为`dlen`的证书`d`的各项内容到输出流`fp`中。

注：头文件中所有`x509_..._print`格式的函数功能与此相同，依名称不同打印并输出证书的特定部分内容。

