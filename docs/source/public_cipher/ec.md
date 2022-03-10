# 椭圆曲线

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
2. 计算$\alpha\bmod p$的平方根$\beta$，若不存在则报错；
3. 若$\beta$的最右侧比特等于$\overline{y_P}$，则置$y_P=\beta$；否则置$y_P=p-\beta$。

## 椭圆曲线密码

to be continued

## 命名椭圆曲线

目前椭圆曲线密码中常用的椭圆曲线包括：

### sm2

| 参数 | 值                                                           |
| ---- | ------------------------------------------------------------ |
| p    | `0xfffffffeffffffffffffffffffffffffffffffff00000000ffffffffffffffff` |
| a    | `0xfffffffeffffffffffffffffffffffffffffffff00000000fffffffffffffffc` |
| b    | `0x28e9fa9e9d9f5e344d5a9e4bcf6509a7f39789f515ab8f92ddbcbd414d940e93` |
| G    | `(0x32c4ae2c1f1981195f9904466a39c9948fe30bbff2660be1715a4589334c74c7, 0xbc3736a2f4f6779c59bdcee36b692153d0a9877cc62a474002df32e52139f0a0)` |
| n    | `0xfffffffeffffffffffffffffffffffff7203df6b21c6052b53bbf40939d54123` |
| h    | `0x01`                                                       |

### prime192v1

| 参数 | 值                                                           |
| ---- | ------------------------------------------------------------ |
| p    | `0xfffffffffffffffffffffffffffffffeffffffffffffffff`         |
| a    | `0xfffffffffffffffffffffffffffffffefffffffffffffffc`         |
| b    | `0x64210519e59c80e70fa7e9ab72243049feb8deecc146b9b1`         |
| G    | `(0x188da80eb03090f67cbf20eb43a18800f4ff0afd82ff1012, 0x07192b95ffc8da78631011ed6b24cdd573f977a11e794811)` |
| n    | `0xffffffffffffffffffffffff99def836146bc9b1b4d22831`         |
| h    | `0x1`                                                        |

### prime256v1

| 参数 | 值                                                           |
| ---- | ------------------------------------------------------------ |
| p    | `0xffffffff00000001000000000000000000000000ffffffffffffffffffffffff` |
| a    | `0xffffffff00000001000000000000000000000000fffffffffffffffffffffffc` |
| b    | `0x5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b` |
| G    | `(0x6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296, 0x4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5)` |
| n    | `0xffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551` |
| h    | `0x1`                                                        |

### secp256k1

| 参数 | 值                                                           |
| ---- | ------------------------------------------------------------ |
| p    | `0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f` |
| a    | `0x0000000000000000000000000000000000000000000000000000000000000000` |
| b    | `0x0000000000000000000000000000000000000000000000000000000000000007` |
| G    | `(0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798, 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8)` |
| n    | `0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141` |
| h    | `0x1`                                                        |

### secp384r1

| 参数 | 值                                                           |
| ---- | ------------------------------------------------------------ |
| p    | `0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff` |
| a    | `0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000fffffffc` |
| b    | `0xb3312fa7e23ee7e4988e056be3f82d19181d9c6efe8141120314088f5013875ac656398d8a2ed19d2a85c8edd3ec2aef` |
| G    | `(0xaa87ca22be8b05378eb1c71ef320ad746e1d3b628ba79b9859f741e082542a385502f25dbf55296c3a545e3872760ab7, 0x3617de4a96262c6f5d9e98bf9292dc29f8f41dbd289a147ce9da3113b5f0b8c00a60b1ce1d7e819d7a431d7c90ea0e5f)` |
| n    | `0xffffffffffffffffffffffffffffffffffffffffffffffffc7634d81f4372ddf581a0db248b0a77aecec196accc52973` |
| h    | `0x1`                                                        |

## secp521r1

| 参数 | 值                                                           |
| ---- | ------------------------------------------------------------ |
| p    | `0x01ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff` |
| a    | `0x01fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc` |
| b    | `0x0051953eb9618e1c9a1f929a21a0b68540eea2da725b99b315f3b8b489918ef109e156193951ec7e937b1652c0bd3bb1bf073573df883d2c34f1ef451fd46b503f00` |
| G    | `(0x00c6858e06b70404e9cd9e3ecb662395b4429c648139053fb521f828af606b4d3dbaa14b5e77efe75928fe1dc127a2ffa8de3348b3c1856a429bf97e7e31c2e5bd66, 0x011839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650)` |
| n    | `0x01fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa51868783bf2f966b7fcc0148f709a5d03bb5c9b8899c47aebb6fb71e91386409` |
| h    | `0x1`                                                        |

## 相关接口

```c
const char *ec_curve_name(int curve);
```

对给定的椭圆曲线OID值`curve`返回对应的椭圆曲线名称（支持的曲线在上一节中已全部列出，下同），如果`curve`对应的椭圆曲线不在此列，则返回`NULL`。

```c
int ec_curve_from_name(const char *name);
```

对给定的椭圆曲线名称`name`返回对应的OID（具体值在`oid.h`中定义），如果给定的椭圆曲线不在此列，则返回值`OID_undef`。

```c
int ec_public_key_algor_to_der(int curve, uint8_t **out, size_t *outlen);
int ec_public_key_algor_from_der(int *curve, const uint8_t **in, size_t *inlen);
```

这两个函数没有对应源代码；功能暂时空缺

~~`ec_public_key_algor_to_der`函数将给定的椭圆曲线OID值`curve`转换为DER格式，并按ASN1标准将每一项内容及其长度存放到`out`和`outlen`中；`ec_public_key_algor_from_der`则从给定的数组`in`和长度信息`inlen`中读取DER格式的椭圆曲线并将其写入`curve`中。函数执行成功返回1，失败返回-1。~~

