# SM2公钥恢复

```c
int sm2_signature_to_public_key_points(const SM2_SIGNATURE *sig, const uint8_t dgst[32], SM2_POINT points[4], size_t *points_cnt);
```

以SM2签名`sig`和被签名消息的哈希值`dgst`作为输入，恢复出可能的`points_cnt`个SM2公钥（椭圆曲线点）值并写入到`points`结构中。函数执行成功返回1，失败返回-1。
