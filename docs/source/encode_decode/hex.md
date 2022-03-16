# HEX字符串

```c
int hex_to_bytes(const char *in, size_t inlen, uint8_t *out, size_t *outlen);
```

将长度为`inlen`的十六进制字符串`in`转换为字节数组，并将内容和长度分别存放到`out`和`outlen`中。

函数执行成功返回1，失败返回-1。
