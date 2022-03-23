# 证书注销列表

X.509证书注销列表以如下格式组织：

```c
CRLReason ::= ENUMERATED // 见后文“部分接口”部分

CRL Entry Extensions:
	OID_ce_crl_reasons		ENUMERATED // 注销原因
	OID_ce_invalidity_date		GeneralizedTime // 注销时间
	OID_ce_certificate_issuer	SEQUENCE		GeneralNames // 证书发行者

RevokedCertificate ::= SEQUENCE { // 已注销证书
	userCertificate		CertificateSerialNumber, // 证书序列号
	revocationDate		Time, // 注销时间
	crlEntryExtensions	Extensions OPTIONAL // 扩展信息
}

RevokedCertificates ::= SEQUENCE OF RevokedCertificate // 已注销证书集合

CRL Extensions:
	OID_ce_authority_key_identifier		SEQUENCE	AuthorityKeyIdentifier
	OID_ce_issuer_alt_name			SEQUENCE	GeneralNames
	OID_ce_crl_number			INTEGER
	OID_ce_delta_crl_indicator		INTEGER
	OID_ce_issuing_distribution_point	SEQUENCE	IssuingDistributionPoint

TBSCertList ::= SEQUENCE {
	version			INTEGER OPTIONAL, -- if present, MUST be v2 // 证书版本号（可选）
	signature		AlgorithmIdentifier, // 证书签名算法标识
	issuer			Name, // 证书发行者名称
	thisUpdate		Time, // 开始生效日期
	nextUpdate		Time OPTIONAL, // 失效日期（可选）
	revokedCertificates	RevokedCertificates OPTIONAL, // 已注销证书集合（可选）
	crlExtensions		[0] EXPLICIT Extensions OPTIONAL, -- if present, MUST be v2 // 扩展信息（可选）
}

CertificateList ::= SEQUENCE { // 证书列表
	tbsCertList		TBSCertList, // 证书主体列表
	signatureAlgorithm	AlgorithmIdentifier, // 证书签名算法标识
	signatureValue		BIT STRING // 证书签名值
}
```

## 部分接口

本部分头文件中的接口与“X.509证书”部分的接口功能基本一致，但面向对象为证书注销列表（而非证书），在此不再赘述。

```c
typedef enum {
	X509_cr_unspecified = 0,
	X509_cr_key_compromise = 1,
	X509_cr_ca_compromise = 2 ,
	X509_cr_affiliation_changed = 3,
	X509_cr_superseded = 4,
	X509_cr_cessation_of_operation = 5,
	X509_cr_certificate_hold = 6,
	X509_cr_not_assigned = 7,
	X509_cr_remove_from_crl = 8,
	X509_cr_privilege_withdrawn = 9,
	X509_cr_aa_compromise = 10,
} X509_CRL_REASON;
```

该枚举类型用于表示证书注销原因。

```c
int x509_crl_sign(uint8_t *crl, size_t *crl_len,
	int version,
	int signature_algor,
	const uint8_t *issuer, size_t issuer_len,
	time_t this_update,
	time_t next_update,
	const uint8_t *revoked_certs, size_t revoked_certs_len,
	const uint8_t *exts, size_t exts_len,
	const SM2_KEY *sign_key, const char *signer_id, size_t signer_id_len);
```

使用SM2签名算法，对证书注销列表`crl`进行签名。

```c
int x509_crl_verify(const uint8_t *a, size_t alen,
	const SM2_KEY *sign_pub_key, const char *signer_id, size_t signer_id_len);
```

以签名者的公钥`sign_pub_key`和身份信息`signer_id`验证DER格式证书`a`的SM2签名。

```c
int x509_crl_get_details(const uint8_t *crl, size_t crl_len,
	int *version,
	const uint8_t **issuer, size_t *issuer_len,
	time_t *this_update,
	time_t *next_update,
	const uint8_t **revoked_certs, size_t *revoked_certs_len,
	int *signature_algor,
	const uint8_t *sig, size_t *siglen);
```

将认证申请`crl`的各项信息存放在指定的数组中。

```c
int x509_crls_print(FILE *fp, int fmt, int ind, const char *label, const uint8_t *d, size_t dlen);
```

调用`vfprintf`等系统函数，打印长为`dlen`的认证申请`d`的各项内容到输出流`fp`中。

