# SM2算法

## 椭圆曲线

有限域$F_q$上的椭圆曲线是由点组成的集合。在仿射坐标系下，椭圆曲线上点$P$（非无穷远点）的坐标表示为$P=(x_P,y_P)$，其中$x_P,y_P$为满足一定方程的域元素，分别称为点$P$的$x$坐标和$y$坐标。

定义在$F_p$（$p>3$且为素数）上的椭圆曲线方程为
$$
y^2=x^3+ax+b\qquad(a,b\in F_p\land(4a^3+27b^2)\bmod p \neq 0)
$$
椭圆曲线$E(F_p)$定义为$E(F_p)=\{(x,y)|x,y\in F_p,且满足上述方程\}\cup\{O\}$，其中$O$是无穷远点。

椭圆曲线$E(F_p)$上点的数目记作$\#E(F_p)$，称为椭圆曲线$E(F_p)$的阶。

## 椭圆曲线算术

椭圆曲线$E(F_p)$上的点按照下面的加法运算规则，构成一个交换群：

1. $O+O=O$；

2. $\forall P=(x,y)\in E(F_p)-\{O\}$，$P+O=O+P=P$；

3. $\forall P=(x,y)\in E(F_p)-\{O\}$，$P$的逆元素$-P=(x,-y)$，$P+(-P)=O$；

4. $\forall P_1=(x_1,y_1),P_2=(x_2,y_2)\in E(F_p)-\{O\},x_1\neq x_2$，设$P_3=(x_3,y_3)=P_1+P_2$，则
   $$
   x_3=\lambda^2-x_1-x_2\\
   y_3=\lambda(x_1-x_3)-y_1
   $$
   其中$\lambda=(y_2-y_1)/(x_2-x_1)$；

5. $\forall P_1=(x_1,y_1)\in E(F_p)-\{O\},y_1\neq 0$，设$P_3=(x_3,y_3)=P_1+P_1$​，则
   $$
   x_3=\lambda^2-2x_1\\
   y_3=\lambda(x_1-x_3)-y_1
   $$
   其中$\lambda=(3x_1^2+a)/2y_1$。

椭圆曲线上同一个点的多次加称为该点的多倍点运算：设$k$是一个正整数，$P$是椭圆曲线上的点，称点$P$的$k$次加为点$P$的$k$倍点运算，记为$Q=[k]P$。因为$[k]P=[k-1]P+P$，所以$k$倍点可以递归求得。多倍点运算的结果有可能是无穷远点$O$。

## 椭圆曲线上点的压缩

对于椭圆曲线$E(F_q)$上的任意非无穷远点$P=(x_P,y_P)$，该点可以由仅存储$x$坐标$x_P\in F_q$以及由$x_P,y_P$导出的一个特定比特简洁地表示，称为点的压缩表示。

具体地，设$P=(x_P,y_P)$是定义在$F_p$上椭圆曲线$E:y^2=x^3+ax+b$上的一个点，$\overline{y_P}$是$y_P$的最右侧比特，则点$P$可由$x_P,\overline{y_P}$表示。恢复$y_P$的方法为：

1. 计算域元素$\alpha=(x_P^3+ax_P+b)\bmod p$；
2.  计算$\alpha\bmod p$的平方根$\beta$，若不存在则报错；
3. 若$\beta$的最右侧比特等于$\overline{y_P}$，则置$y_P=\beta$；否则置$y_P=p-\beta$。

## 椭圆曲线算术接口

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
