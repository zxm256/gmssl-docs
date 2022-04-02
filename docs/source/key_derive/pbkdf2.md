# PBKDF2

PBKDF（Password-Based Key Derive Function）是一种基于伪随机函数的密钥派生算法，该算法将伪随机函数应用于用户输入的密钥材料，并由此派生出符合安全性要求的密钥。

```c
int pbkdf2_genkey(const DIGEST *digest,
	const char *pass, size_t passlen, const uint8_t *salt, size_t saltlen, size_t iter,
	size_t outlen, uint8_t *out);
```

对于用户给定的字符串口令`pass`（长度为`passlen`），函数对其加盐后的文本运行哈希算法`iter`次，从中提取随机化的密钥并将其内容和长度分别写入`out`和`outlen`中。数组`salt`为哈希函数中加入的盐值，长度应为`saltlen`。

由于需要运行哈希函数，因此还应提供一个摘要上下文结构`digest`（见“HMAC算法”部分）。

函数总是返回1。

```c
int pbkdf2_hmac_sm3_genkey(
	const char *pass, size_t passlen, const uint8_t *salt, size_t saltlen, size_t iter,
	size_t outlen, uint8_t *out);
```

通过SM3哈希和HMAC算法生成密钥，各参数含义和返回值同上。
