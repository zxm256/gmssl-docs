# asn1.h

# ASN.1/DER编码

详细内容参见[GmSSL-ASN1-code](https://github.com/guanzhi/gmssl-v3-dev/blob/main/src/asn1.c)。

```c
const char *asn1_tag_name(int tag);
int asn1_tag_to_der(int tag, uint8_t **out, size_t *outlen);
int asn1_tag_from_der(int tag, const uint8_t **in, size_t *inlen);
int asn1_any_tag_from_der(int *tag, const uint8_t **in, size_t *inlen);
int asn1_tag_get(int *tag, const uint8_t **in, size_t *inlen);
int asn1_tag_is_cstring(int tag);
```

ASN.1标签的编解码。

```c
int asn1_length_to_der(size_t dlen, uint8_t **out, size_t *outlen);
int asn1_length_from_der(size_t *dlen, const uint8_t **in, size_t *inlen);
int asn1_length_is_zero(size_t len);
int asn1_length_le(size_t len1, size_t len2);
int asn1_data_to_der(const uint8_t *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_data_from_der(const uint8_t **d, size_t dlen, const uint8_t **in, size_t *inlen);
```

ASN.1长度和数据的编解码。

```c
int asn1_type_to_der(int tag, const uint8_t *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_type_from_der(int tag, const uint8_t **d, size_t *dlen, const uint8_t **in, size_t *inlen);
int asn1_any_type_from_der(int *tag, const uint8_t **d, size_t *dlen, const uint8_t **in, size_t *inlen);
int asn1_any_to_der(const uint8_t *a, size_t alen, uint8_t **out, size_t *outlen);
int asn1_any_from_der(const uint8_t **a, size_t *alen, const uint8_t **in, size_t *inlen);
```

ASN.1类型的编解码。

```c
int asn1_boolean_to_der_ex(int tag, int val, uint8_t **out, size_t *outlen);
int asn1_boolean_from_der_ex(int tag, int *val, const uint8_t **in, size_t *inlen);
#define asn1_boolean_to_der(val,out,outlen) asn1_boolean_to_der_ex(ASN1_TAG_BOOLEAN,val,out,outlen)
#define asn1_boolean_from_der(val,in,inlen) asn1_boolean_from_der_ex(ASN1_TAG_BOOLEAN,val,in,inlen)
#define asn1_implicit_boolean_to_der(i,val,out,outlen) asn1_boolean_to_der_ex(ASN1_TAG_IMPLICIT(i),val,out,outlen)
#define asn1_implicit_boolean_from_der(i,val,in,inlen) asn1_boolean_from_der_ex(ASN1_TAG_IMPLICIT(i),val,in,inlen)
```

ASN.1布尔类型的编解码。

```c
int asn1_integer_to_der_ex(int tag, const uint8_t *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_integer_from_der_ex(int tag, const uint8_t **d, size_t *dlen, const uint8_t **in, size_t *inlen);
#define asn1_integer_to_der(d,dlen,out,outlen) asn1_integer_to_der_ex(ASN1_TAG_INTEGER,d,dlen,out,outlen)
#define asn1_integer_from_der(d,dlen,in,inlen) asn1_integer_from_der_ex(ASN1_TAG_INTEGER,d,dlen,in,inlen)
#define asn1_implicit_integer_to_der(i,d,dlen,out,outlen) asn1_integer_to_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_integer_from_der(i,d,dlen,in,inlen) asn1_integer_from_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,in,inlen)
```

ASN.1整数的编解码。

```c
int asn1_int_to_der_ex(int tag, int val, uint8_t **out, size_t *outlen); // 当 val == -1 时，不输出，返回 0
int asn1_int_from_der_ex(int tag, int *val, const uint8_t **in, size_t *inlen); // 不支持负数，返回0时 *val 设置为 -1
#define asn1_int_to_der(val,out,outlen) asn1_int_to_der_ex(ASN1_TAG_INTEGER,val,out,outlen)
#define asn1_int_from_der(val,in,inlen) asn1_int_from_der_ex(ASN1_TAG_INTEGER,val,in,inlen)
#define asn1_implicit_int_to_der(i,val,out,outlen) asn1_int_to_der_ex(ASN1_TAG_IMPLICIT(i),val,out,outlen)
#define asn1_implicit_int_from_der(i,val,in,inlen) asn1_int_from_der_ex(ASN1_TAG_IMPLICIT(i),val,in,inlen)
```

ASN.1无符号整数的编解码。注意：不支持负数。

// 比特长度不必须为8的整数倍

```c
int asn1_bit_string_to_der_ex(int tag, const uint8_t *d, size_t nbits, uint8_t **out, size_t *outlen);
int asn1_bit_string_from_der_ex(int tag, const uint8_t **d, size_t *nbits, const uint8_t **in, size_t *inlen);
#define asn1_bit_string_to_der(d,nbits,out,outlen) asn1_bit_string_to_der_ex(ASN1_TAG_BIT_STRING,d,nbits,out,outlen)
#define asn1_bit_string_from_der(d,nbits,in,inlen) asn1_bit_string_from_der_ex(ASN1_TAG_BIT_STRING,d,nbits,in,inlen)
#define asn1_implicit_bit_string_to_der(i,d,nbits,out,outlen) asn1_bit_string_to_der_ex(ASN1_TAG_IMPLICIT(i),d,nbits,out,outlen)
#define asn1_implicit_bit_string_from_der(i,d,nbits,in,inlen) asn1_bit_string_from_der_ex(ASN1_TAG_IMPLICIT(i),d,nbits,in,inlen)
```

ASN.1比特串的编解码。对比特串的长度没有要求。

```c
int asn1_bit_octets_to_der_ex(int tag, const uint8_t *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_bit_octets_from_der_ex(int tag, const uint8_t **d, size_t *dlen, const uint8_t **in, size_t *inlen);
#define asn1_bit_octets_to_der(d,dlen,out,outlen) asn1_bit_octets_to_der_ex(ASN1_TAG_BIT_STRING,d,dlen,out,outlen)
#define asn1_bit_octets_from_der(d,dlen,in,inlen) asn1_bit_octets_from_der_ex(ASN1_TAG_BIT_STRING,d,dlen,in,inlen)
#define asn1_implicit_bit_octets_to_der(i,d,dlen,out,outlen) asn1_bit_octets_to_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_bit_octets_from_der(i,d,dlen,in,inlen) asn1_bit_octets_from_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,in,inlen)
```

ASN.1字节比特串的编解码。注意：比特长度必须为8的整数倍，因此使用字节类型。

```c
int asn1_bits_to_der_ex(int tag, int bits, uint8_t **out, size_t *outlen);
int asn1_bits_from_der_ex(int tag, int *bits, const uint8_t **in, size_t *inlen);
#define asn1_bits_to_der(bits,out,outlen) asn1_bits_to_der_ex(ASN1_TAG_BIT_STRING,bits,out,outlen)
#define asn1_bits_from_der(bits,in,inlen) asn1_bits_from_der_ex(ASN1_TAG_BIT_STRING,bits,in,inlen)
#define asn1_implicit_bits_to_der(i,bits,out,outlen) asn1_bits_to_der_ex(ASN1_TAG_IMPLICIT(i),bits,out,outlen)
#define asn1_implicit_bits_from_der(i,bits,in,inlen) asn1_bits_from_der_ex(ASN1_TAG_IMPLICIT(i),bits,in,inlen)
// names[i]对应第i个比特
int asn1_bits_print(FILE *fp, int fmt, int ind, const char *label, const char **names, size_t names_cnt, int bits);
```

ASN.1较少比特数量的编解码。

```c
#define asn1_octet_string_to_der_ex(tag,d,dlen,out,outlen) asn1_type_to_der(tag,d,dlen,out,outlen)
#define asn1_octet_string_from_der_ex(tag,d,dlen,in,inlen) asn1_type_from_der(tag,d,dlen,in,inlen)
#define asn1_octet_string_to_der(d,dlen,out,outlen) asn1_type_to_der(ASN1_TAG_OCTET_STRING,d,dlen,out,outlen)
#define asn1_octet_string_from_der(d,dlen,in,inlen) asn1_type_from_der(ASN1_TAG_OCTET_STRING,d,dlen,in,inlen)
#define asn1_implicit_octet_string_to_der(i,d,dlen,out,outlen) asn1_type_to_der(ASN1_TAG_IMPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_octet_string_from_der(i,d,dlen,in,inlen) asn1_type_from_der(ASN1_TAG_IMPLICIT(i),d,dlen,in,inlen)
```

ASN.1字节串的编解码。

```c
int asn1_null_to_der(uint8_t **out, size_t *outlen);
int asn1_null_from_der(const uint8_t **in, size_t *inlen);
```

ASN.1空值的编解码。

```c
#define ASN1_OID_MAX_NODES 32
int asn1_object_identifier_to_octets(const uint32_t *nodes, size_t nodes_cnt, uint8_t *out, size_t *outlen);
int asn1_object_identifier_from_octets(uint32_t *nodes, size_t *nodes_cnt, const uint8_t *in, size_t inlen);

int asn1_object_identifier_equ(const uint32_t *a, size_t a_cnt, const uint32_t *b, size_t b_cnt);
int asn1_object_identifier_to_der_ex(int tag, const uint32_t *nodes, size_t nodes_cnt, uint8_t **out, size_t *outlen);
int asn1_object_identifier_from_der_ex(int tag, uint32_t *nodes, size_t *nodes_cnt, const uint8_t **in, size_t *inlen);
#define asn1_object_identifier_to_der(nodes,nodes_cnt,out,outlen) asn1_object_identifier_to_der_ex(ASN1_TAG_OBJECT_IDENTIFIER,nodes,nodes_cnt,out,outlen)
#define asn1_object_identifier_from_der(nodes,nodes_cnt,in,inlen) asn1_object_identifier_from_der_ex(ASN1_TAG_OBJECT_IDENTIFIER,nodes,nodes_cnt,in,inlen)
#define asn1_implicit_object_identifier_to_der(i,nodes,nodes_cnt,out,outlen) asn1_object_identifier_to_der_ex(ASN1_TAG_IMPLICIT(i),nodes,nodes_cnt,out,outlen)
#define asn1_implicit_object_identifier_from_der(i,nodes,nodes_cnt,in,inlen) asn1_object_identifier_from_der_ex(ASN1_TAG_IMPLICIT(i),nodes,nodes_cnt,in,inlen)
int asn1_object_identifier_print(FILE *fp, int fmt, int ind, const char *label, const char *name,
	const uint32_t *nodes, size_t nodes_cnt);
```

ASN.1对OID数据的编解码。

```c
#define asn1_enumerated_to_der_ex(tag,val,out,outlen) asn1_int_to_der_ex(tag,val,out,outlen)
#define asn1_enumerated_from_der_ex(tag,val,in,inlen) asn1_int_from_der_ex(tag,val,in,inlen)
#define asn1_enumerated_to_der(val,out,outlen) asn1_int_to_der_ex(ASN1_TAG_ENUMERATED,val,out,outlen)
#define asn1_enumerated_from_der(val,in,inlen) asn1_int_from_der_ex(ASN1_TAG_ENUMERATED,val,in,inlen)
#define asn1_implicit_enumerated_to_der(i,val,out,outlen) asn1_int_to_der_ex(ASN1_TAG_IMPLICIT(i),val,out,outlen)
#define asn1_implicit_enumerated_from_der(i,val,in,inlen) asn1_int_from_der_ex(ASN1_TAG_IMPLICIT(i),val,in,inlen)
```

ASN.1枚举类型的编解码。

```c
int asn1_utf8_string_check(const char *d, size_t dlen);
int asn1_utf8_string_to_der_ex(int tag, const char *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_utf8_string_from_der_ex(int tag, const char **d, size_t *dlen, const uint8_t **in, size_t *inlen);
#define asn1_utf8_string_to_der(d,dlen,out,outlen) asn1_utf8_string_to_der_ex(ASN1_TAG_UTF8String,d,dlen,out,outlen)
#define asn1_utf8_string_from_der(d,dlen,in,inlen) asn1_utf8_string_from_der_ex(ASN1_TAG_UTF8String,d,dlen,in,inlen)
#define asn1_implicit_utf8_string_to_der(i,d,dlen,out,outlen) asn1_utf8_string_to_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_utf8_string_from_der(i,d,dlen,in,inlen) asn1_utf8_string_from_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,in,inlen)
```

ASN.1对UTF-8字符串的编解码。

```c
int asn1_printable_string_check(const char *d, size_t dlen);
int asn1_printable_string_to_der_ex(int tag, const char *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_printable_string_from_der_ex(int tag, const char **d, size_t *dlen, const uint8_t **in, size_t *inlen);
#define asn1_printable_string_to_der(d,dlen,out,outlen)	asn1_printable_string_to_der_ex(ASN1_TAG_PrintableString,d,dlen,out,outlen)
#define asn1_printable_string_from_der(d,dlen,in,inlen)	asn1_printable_string_from_der_ex(ASN1_TAG_PrintableString,d,dlen,in,inlen)
#define asn1_implicit_printable_string_to_der(i,d,dlen,out,outlen) asn1_printable_string_to_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_printable_string_from_der(i,d,dlen,in,inlen) asn1_printable_string_from_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,in,inlen)
```

ASN.1可打印字符串类型的编解码。

```c
int asn1_ia5_string_check(const char *d, size_t dlen);
int asn1_ia5_string_to_der_ex(int tag, const char *d, size_t dlen, uint8_t **out, size_t *outlen);
int asn1_ia5_string_from_der_ex(int tag, const char **d, size_t *dlen, const uint8_t **in, size_t *inlen);
#define asn1_ia5_string_to_der(d,dlen,out,outlen) asn1_ia5_string_to_der_ex(ASN1_TAG_IA5String,d,dlen,out,outlen)
#define asn1_ia5_string_from_der(d,dlen,in,inlen) asn1_ia5_string_from_der_ex(ASN1_TAG_IA5String,d,dlen,in,inlen)
#define asn1_implicit_ia5_string_to_der(i,d,dlen,out,outlen) asn1_ia5_string_to_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_ia5_string_from_der(i,d,dlen,in,inlen) asn1_ia5_string_from_der_ex(ASN1_TAG_IMPLICIT(i),d,dlen,in,inlen)
```

ASN.1对IA5字符串类型的编解码。

```c
#define ASN1_UTC_TIME_LEN		(sizeof("YYMMDDHHMMSSZ")-1)
#define ASN1_GENERALIZED_TIME_LEN	(sizeof("YYYYMMDDHHMMSSZ")-1)

int asn1_utc_time_to_der_ex(int tag, time_t tv, uint8_t **out, size_t *outlen);
int asn1_utc_time_from_der_ex(int tag, time_t *tv, const uint8_t **in, size_t *inlen);
#define asn1_utc_time_to_der(tv,out,outlen) asn1_utc_time_to_der_ex(ASN1_TAG_UTCTime,tv,out,outlen)
#define asn1_utc_time_from_der(tv,in,inlen) asn1_utc_time_from_der_ex(ASN1_TAG_UTCTime,tv,in,inlen)
#define asn1_implicit_utc_time_to_der(i,tv,out,outlen) asn1_utc_time_to_der_ex(ASN1_TAG_IMPLICIT(i),tv,out,outlen)
#define asn1_implicit_utc_time_from_der(i,tv,in,inlen) asn1_utc_time_from_der_ex(ASN1_TAG_IMPLICIT(i),tv,in,inlen)

int asn1_generalized_time_to_der_ex(int tag, time_t tv, uint8_t **out, size_t *outlen);
int asn1_generalized_time_from_der_ex(int tag, time_t *tv, const uint8_t **in, size_t *inlen);
#define asn1_generalized_time_to_der(tv,out,outlen) asn1_generalized_time_to_der_ex(ASN1_TAG_GeneralizedTime,tv,out,outlen)
#define asn1_generalized_time_from_der(tv,in,inlen) asn1_generalized_time_from_der_ex(ASN1_TAG_GeneralizedTime,tv,in,inlen)
#define asn1_implicit_generalized_time_to_der(i,tv,out,outlen) asn1_generalized_time_to_der_ex(ASN1_TAG_IMPLICIT(i),tv,out,outlen)
#define asn1_implicit_generalized_time_from_der(i,tv,in,inlen) asn1_generalized_time_from_der_ex(ASN1_TAG_IMPLICIT(i),tv,in,inlen)
```

ASN.1时间类型（包括UTC时间和通用时间）的编解码。

```c
#define asn1_sequence_to_der(d,dlen,out,outlen) asn1_type_to_der(ASN1_TAG_SEQUENCE,d,dlen,out,outlen)
#define asn1_sequence_from_der(d,dlen,in,inlen) asn1_type_from_der(ASN1_TAG_SEQUENCE,d,dlen,in,inlen)
#define asn1_implicit_sequence_to_der(i,d,dlen,out,outlen) asn1_type_to_der(ASN1_TAG_EXPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_sequence_from_der(i,d,dlen,in,inlen) asn1_type_from_der(ASN1_TAG_EXPLICIT(i),d,dlen,in,inlen)
```

ASN.1结构类型的编解码。

```c
#define asn1_set_to_der(d,dlen,out,outlen) asn1_type_to_der(ASN1_TAG_SET,d,dlen,out,outlen)
#define asn1_set_from_der(d,dlen,in,inlen) asn1_type_from_der(ASN1_TAG_SET,d,dlen,in,inlen)
#define asn1_implicit_set_to_der(i,d,dlen,out,outlen) asn1_type_to_der(ASN1_TAG_EXPLICIT(i),d,dlen,out,outlen)
#define asn1_implicit_set_from_der(i,d,dlen,in,inlen) asn1_type_from_der(ASN1_TAG_EXPLICIT(i),d,dlen,in,inlen)
```

ASN.1集合类型的编解码。

```c
typedef struct {
	int oid;
	char *name;
	uint32_t *nodes;
	size_t nodes_cnt;
	int flags;
	char *description;
} ASN1_OID_INFO;

const ASN1_OID_INFO *asn1_oid_info_from_name(const ASN1_OID_INFO *infos, size_t count, const char *name);
const ASN1_OID_INFO *asn1_oid_info_from_oid(const ASN1_OID_INFO *infos, size_t count, int oid);
int asn1_oid_info_from_der_ex(const ASN1_OID_INFO **info, uint32_t *nodes, size_t *nodes_cnt,
	const ASN1_OID_INFO *infos, size_t count, const uint8_t **in, size_t *inlen);
int asn1_oid_info_from_der(const ASN1_OID_INFO **info,
	const ASN1_OID_INFO *infos, size_t count, const uint8_t **in, size_t *inlen);
```

OID信息类型结构体及ASN.1对OID信息类型的编解码。

```c
int asn1_check(int expr);
```


检查给定的值`expr`是否符合ASN.1要求，是则返回1，否则返回-1。
