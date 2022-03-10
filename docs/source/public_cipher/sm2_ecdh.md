# SM2密钥交换

# SM2密钥交换

```c
int sm2_ecdh(const SM2_KEY *key, const SM2_POINT *peer_public, SM2_POINT *out);
```

以调用者的密钥`key`和密钥协商者发送的椭圆曲线点`peer_public`作为输入，计算协商出的公钥（椭圆曲线点）值并写入到`out`结构中。函数执行成功返回1，失败返回-1。
