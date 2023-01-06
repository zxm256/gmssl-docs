# SM2承诺(Pederson)

```c
int sm2_commit_generate(const uint8_t x[32], uint8_t r[32], uint8_t commit[65], size_t *commitlen);
```

以256位整数`x`和`r`作为输入，计算对`x`的承诺值`commit`（椭圆曲线点，下同）。函数执行成功返回1，失败返回-1。

```c
int sm2_commit_open(const uint8_t x[32], const uint8_t r[32], const uint8_t *commit, size_t commitlen);
```

以256位整数`x`、`r`和对`x`的承诺值`commit`作为输入，验证承诺。验证通过返回1，不通过或函数执行失败返回-1。

```c
int sm2_commit_vector_generate(const sm2_bn_t *x, size_t count, uint8_t r[32], uint8_t commit[65], size_t *commitlen);
```

以`count`个256位整数构成的数组`x`和`r`作为输入，计算对该数组的承诺值`commit`。函数执行成功返回1，失败返回-1。

```c
int sm2_commit_vector_open(const sm2_bn_t *x, size_t count, const uint8_t r[32], const uint8_t *commit, size_t commitlen);
```

以`count`个256位整数构成的数组`x`和`r`作为输入，计算对该数组的承诺值`commit`。验证通过返回1，不通过或函数执行失败返回-1。
