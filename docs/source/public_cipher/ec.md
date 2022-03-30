# 椭圆曲线

有限域F_p上的椭圆曲线是由点组成的集合。椭圆曲线上点P（非无穷远点）的坐标表示为P=(x_P,y_P)，其中x_P,y_P为域元素且满足下文给出的方程。

定义在F_p（p>3且为素数）上的椭圆曲线方程为y^2=x^3+ax+b，其中4a^3+27b^2模p不为0。 椭圆曲线E(F_p)由有限域F_p在其上的所有点和一个无穷远点构成。

椭圆曲线上点的数目称为椭圆曲线的阶。

## 椭圆曲线算术

椭圆曲线上的点按照一定的加法运算规则构成一个交换群，椭圆曲线上同一个点的多次加称为该点的多倍点运算，可以递归求得。

## 椭圆曲线上点的压缩

对于椭圆曲线上的任意非无穷远点P=(x_P,y_P)，该点可以由仅存储x坐标x_P以及由x_P,y_P导出的一个特定比特简洁地表示，称为点的压缩表示。

具体地，设P=(x_P,y_P)是定义在F_p上椭圆曲线E:y^2=x^3+ax+b上的一个点，yP是y_P的最右侧比特，则点P可由x_P,yP表示。

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

