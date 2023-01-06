# SM2密钥分享

```c
typedef struct {
	SM2_KEY key;
	size_t index;
	size_t total_cnt;
} SM2_KEY_SHARE;
```

SM2密钥份额结构`SM2_KEY_SHARE`包含：分享的密钥份额`key`、份额编号`index`和总份额数量`total_cnt`。

```c
int sm2_key_split(const SM2_KEY *key, size_t recover_cnt, size_t total_cnt, SM2_KEY_SHARE *shares);
```

以待分享密钥`key`、恢复所需的份额阈值数量`recover_cnt`和总份额数量`total_cnt`作为输入，计算密钥分享值并写入到份额结构数组`shares`结构中。函数执行成功返回1，失败返回-1。

```c
int sm2_key_recover(SM2_KEY *key, const SM2_KEY_SHARE *shares, size_t shares_cnt);
```

以份额结构数组`shares`和数量`shares_cnt`作为输入，计算密钥分享值并写入到SM2密钥结构`key`结构中。函数执行成功返回1，失败返回-1。

```c
int sm2_key_share_encrypt_to_file(const SM2_KEY_SHARE *share, const char *pass, const char *path_prefix);
int sm2_key_share_decrypt_from_file(SM2_KEY_SHARE *share, const char *pass, const char *file);
```

实现SM2密钥分享信息在份额结构和文件格式间的相互转换。函数执行成功返回1，失败返回-1。
