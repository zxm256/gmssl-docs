# SM2算法

```c
typedef struct {
	uint8_t x[32];
	uint8_t y[32];
} SM2_POINT;
```

`SM2_POINT`结构包含两个成员变量x和y，分别代表SM2椭圆曲线上点的$x$坐标和$y$坐标，以256位大整数表示。

```c
void sm2_point_to_compressed_octets(const SM2_POINT *P, uint8_t out[33]);
```

将SM2椭圆曲线上的点`P`转换为压缩字节格式并存放到字节数组`out`中，长度固定为33字节。

```c
void sm2_point_to_uncompressed_octets(const SM2_POINT *P, uint8_t out[65]);
```

将SM2椭圆曲线上的点`P`转换为非压缩字节格式并存放到字节数组`out`中，长度固定为65字节。

```c
int sm2_point_from_octets(SM2_POINT *P, const uint8_t *in, size_t inlen);
```

从压缩或非压缩字节格式的、长度为`inlen`的字节数组`in`中读取SM2椭圆曲线上的点并将其写入结构`P`中。函数执行成功返回1，失败返回-1。

```c
int sm2_point_to_der(const SM2_POINT *P, uint8_t **out, size_t *outlen);
```

将SM2椭圆曲线点结构`P`转换为DER格式，并按ASN1标准将每一项内容及其长度存放到`out`和`outlen`中。函数执行成功返回1，失败返回-1。

```c
int sm2_point_from_der(SM2_POINT *P, const uint8_t **in, size_t *inlen);
```

从给定的数组`in`和长度信息`inlen`中读取DER格式的SM2椭圆曲线点，并将其写入点结构`P`中。函数执行成功返回1，失败返回-1。

```c
int sm2_point_from_x(SM2_POINT *P, const uint8_t x[32], int y);
```

从给定的椭圆曲线点的$x$坐标和压缩信息$y$恢复椭圆曲线点的值，并将其写入点结构`P`中。函数执行成功返回1，失败返回-1。

```c
int sm2_point_from_xy(SM2_POINT *P, const uint8_t x[32], const uint8_t y[32]);
```

从给定的椭圆曲线点的$x$坐标和$y$坐标恢复椭圆曲线点的值，并将其写入点结构`P`中。如果该点在SM2椭圆曲线上，返回1，否则返回0。

```c
int sm2_point_is_on_curve(const SM2_POINT *P);
```

检查给定的点`P`是否在SM2椭圆曲线上，是则返回1，否则返回0。

```c
int sm2_point_mul(SM2_POINT *R, const uint8_t k[32], const SM2_POINT *P);
```

计算给定的椭圆曲线点`P`的`k`倍点，并将结果写入点结构`R`中。函数总是返回1。

```c
int sm2_point_mul_generator(SM2_POINT *R, const uint8_t k[32]);
```

计算SM2椭圆曲线点群的生成元$G$的`k`倍点，并将结果写入点结构`R`中。函数总是返回1。

```c
int sm2_point_mul_sum(SM2_POINT *R, const uint8_t k[32], const SM2_POINT *P, const uint8_t s[32]);
```

对给定椭圆曲线点结构`P`、整数`k`和`s`，计算$R=[k]P+[s]G$（其中$G$为SM2椭圆曲线点群的生成元），并将结果写入点结构`R`中。函数总是返回1。
