# PEM文件格式(pem.h)

```c
int pem_read(FILE *fp, const char *name, uint8_t *out, size_t *outlen, size_t maxlen);
```

`pem_read`函数从PEM文件`fp`中读取信息。`name`为该PEM文件的文件头尾信息，该参数的值需要和提供的PEM文件本身对应。读取的数据以字节形式存放在`out`指向的数组，并由`outlen`指示其长度。

函数执行成功返回1，文件为空返回0，文件头尾信息错误或提前结束返回-1。

***注意：maxlen没有用到，可能需要调整。***

```c
int pem_write(FILE *fp, const char *name, const uint8_t *in, size_t inlen);
```

`pem_write`函数将给定的头尾信息`name`和字节形式的、长度为`inlen`的文件数据`in`写入该文件形成完整的PEM文件`fp`。

函数返回写入的字符总数。
