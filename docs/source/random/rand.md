# 随机数生成接口

```c
int rand_bytes(uint8_t *buf, size_t buflen);
```

`rand_bytes`函数从`/dev/urandom`文件中读取`buflen`字节的随机数并存放至`buf`指向的数组中。

函数执行成功返回1，失败返回-1。
