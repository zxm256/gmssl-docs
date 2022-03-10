## SM2密钥

```c
typedef struct {
	SM2_POINT public_key;
	uint8_t private_key[32];
	uint8_t key_usage[4];
} SM2_KEY;
```

`SM2_KEY`结构包含三个成员变量：私钥`private_key`为一个小于SM2椭圆曲线点群阶的正整数$pk$，以256位大整数形式表示；公钥`public_key`为SM2椭圆曲线上的点$PK$，即私钥与SM2椭圆曲线基点$G$的乘积$[sk]G$；密钥用途`key_usage`指示密钥使用的场景。

```c
int sm2_key_generate(SM2_KEY *key);
```

生成一对以`SM2_KEY`结构表示的公私钥。通过随机数生成算法获得一个小于SM2椭圆曲线点群阶的正整数作为私钥$sk$，并以256位大整数形式表示；私钥与SM2椭圆曲线基点$G$的乘积$PK=[sk]G$作为公钥$PK$，表示为`SM2_POINT`结构。函数执行成功返回1，失败返回-1。

```c
int sm2_key_set_private_key(SM2_KEY *key, const uint8_t private_key[32]);
int sm2_key_set_public_key(SM2_KEY *key, const SM2_POINT *public_key);
```

通过已有的、类型对应的公钥或私钥设置`SM2_KEY`结构中的公私钥值。函数总是返回1。

```c
int sm2_public_key_copy(SM2_KEY *sm2_key, const SM2_KEY *pub_key);
```

复制给定的公钥`pub_key`至`SM2_KEY`结构`sm2_key`。函数执行成功返回1，失败返回-1。

```c
int sm2_public_key_digest(const SM2_KEY *key, uint8_t dgst[32]);
```

计算公钥`pub_key`的SM3哈希值并存放至给定的`dgst`数组。函数执行成功返回1，失败返回-1。
