# HDKF

HKDF（Hash Key Derive Function）是一种基于HMAC的密钥派生算法，该算法接受用户输入的密钥材料，并根据HMAC算法派生出符合安全性要求的密钥。

```c
int hkdf_extract(const DIGEST *digest, const uint8_t *salt, size_t saltlen,
	const uint8_t *ikm, size_t ikmlen,
	uint8_t *prk, size_t *prklen);
```

对于用户给定的密钥材料`ikm`（以字节数组表示，下同；长度为`ikmlen`），函数运行HMAC算法并以`ikm`作为算法的输入，从中提取随机化的密钥并将其内容和长度分别写入`prk`和`prklen`中。数组`salt`为哈希函数中加入的盐值，长度应为`saltlen`。

由于需要运行哈希函数，因此还应提供一个摘要上下文结构`digest`（见“HMAC算法”部分）。

```c
int hkdf_expand(const DIGEST *digest, const uint8_t *prk, size_t prklen,
	const uint8_t *opt_info, size_t opt_infolen,
	size_t L, uint8_t *okm);
```

通过哈希运算将密钥扩展到用户指定的长度`L`。给定已有长度为`prklen`的密钥`prk`、长度为`opt_infolen`的附加可选信息`opt_info`和摘要结构`digest`（见上），函数计算并输出长度为`L`的派生密钥至数组`okm`中。
