# Base64编码

```c
typedef struct {
    /* number saved in a partial encode/decode */
    int num;
    /*
     * The length is either the output line length (in input bytes) or the
     * shortest input line length that is ok.  Once decoding begins, the
     * length is adjusted up each time a longer line is decoded
     */
    int length;
    /* data to encode */
    unsigned char enc_data[80];
    /* number read on current line */
    int line_num;
    int expect_nl;
} BASE64_CTX;
```

`BASE64_CTX`结构包含变量。

```c
# define BASE64_ENCODE_LENGTH(l)    (((l+2)/3*4)+(l/48+1)*2+80)
# define BASE64_DECODE_LENGTH(l)    ((l+3)/4*3+80)
```

定义了Base64编解码的最大长度。

```c
void base64_encode_init(BASE64_CTX *ctx);
```

初始化给定的`BASE64_CTX`结构`ctx`。

```c
int base64_encode_update(BASE64_CTX *ctx, const uint8_t *in, int inlen, uint8_t *out, int *outlen);
```

将长度为`inlen`的字节数组`in`转换为Base64编码，并将内容和长度分别存放到`out`和`outlen`中。函数执行成功返回1，失败返回0。

```c
void base64_encode_finish(BASE64_CTX *ctx, uint8_t *out, int *outlen);
```

将结构`ctx`中剩余的内容全部转换为Base64编码，并将内容和长度分别存放到`out`和`outlen`中。

```c
void base64_decode_init(BASE64_CTX *ctx);
```

初始化给定的`BASE64_CTX`结构`ctx`。

```c
int base64_decode_update(BASE64_CTX *ctx, const uint8_t *in, int inlen, uint8_t *out, int *outlen);
```

将长度为`inlen`的Base64编码数组`in`转换为ASCII编码，并将内容和长度分别存放到`out`和`outlen`中。函数执行成功返回1，失败返回0。

```c
int base64_decode_finish(BASE64_CTX *ctx, uint8_t *out, int *outlen);
```

将结构`ctx`中剩余的内容全部转换为ASCII编码，并将内容和长度分别存放到`out`和`outlen`中。

```c
int base64_encode_block(unsigned char *t, const unsigned char *f, int dlen);
```

将长度为`dlen`的字符串数组`f`转换为Base64编码，并存放到字符串数组`t`中。返回成功转换出的Base64编码字符总数，即`t`的长度。

```c
int base64_decode_block(unsigned char *t, const unsigned char *f, int n);
```

将长度为`n`的Base64编码字符串数组`f`转换为ASCII编码字符，并存放到字符串数组`t`中。返回成功转换出的字符总数，即`t`的长度。
