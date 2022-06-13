# gmssl命令行工具示例

本部分将结合一些典型的应用场景对gmssl命令行工具的具体使用方法进行介绍，具体每个命令行的功能及使用方法请参看上一部分。

## SM2

### SM2密钥对生成

生成SM2私钥sm2.pem，公钥sm2pub.pem

```
gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem
```

### SM2加密解密


首先生成SM2公私钥对

```
gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem
```

然后使用SM2私钥、私钥加密口令对数据进行签名

```
echo hello | gmssl sm2sign -key sm2.pem -pass 1234 -out sm2.sig 

id默认为1234567812345678，也可以手动指定
echo hello | gmssl sm2sign -key sm2.pem -pass 1234 -out sm2.sig -id 1234567812345678
```

### SM2签名验签

生成SM2公私钥对

```
gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem
```

使用SM2私钥、私钥加密口令对数据进行签名

```
echo hello | gmssl sm2sign -key sm2.pem -pass 1234 -out sm2.sig 

id默认为1234567812345678，也可以手动指定
echo hello | gmssl sm2sign -key sm2.pem -pass 1234 -out sm2.sig -id 1234567812345678
```

使用SM2公钥进行验签

```
echo hello | gmssl sm2verify -pubkey sm2pub.pem -sig sm2.sig -id 1234567812345678
```

## SM3算法

使用SM3算法对Linux 管道的数据进行哈希
```
echo -n abc | gmssl sm3
```

当指定-pubkey的时候，表示生成SM2签名所需的中间结果
```
gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem
echo -n abc | gmssl sm3 -pubkey sm2pub.pem 
```

使用指定的key，对Linux管道的数据计算SM3 的HMAC
```
echo -n abc | gmssl sm3hmac -key 11223344556677881122334455667788
```

## SM4算法

设置SM4加密解密用到的参数
```
KEY=11223344556677881122334455667788
IV=11223344556677881122334455667788
```

使用SM4 CBC模式对管道的数据进行加密解密，可以使用-in参数指定加密的文件，-out参数指定输出的文件
```
echo hello | gmssl sm4 -cbc -encrypt -key $KEY -iv $IV -out sm4.cbc
gmssl sm4 -cbc -decrypt -key $KEY -iv $IV -in sm4.cbc
```

使用SM4 CTR模式，对管道的数据进行加密解密，可以使用-in参数指定加密的文件，-out参数指定输出的文件
```
echo hello | gmssl sm4 -ctr -encrypt -key $KEY -iv $IV -out sm4.ctr
gmssl sm4 -ctr -decrypt -key $KEY -iv $IV -in sm4.ctr
```
## SM9算法


### SM9签名验签

初始化生成SM9 主公钥sign_mpk.pem、主私钥sign_msk.pem

```
gmssl sm9setup -alg sm9sign -pass 1234 -out sign_msk.pem -pubout sign_mpk.pem
```

使用主私钥生成用户alice的用户私钥alice.pem，并使用outpass参数指定的口令加密
```
gmssl sm9keygen -alg sm9sign -in sign_msk.pem -inpass 1234 -id alice -out alice.pem -outpass 1234
```

使用用户alice的用户私钥对数据进行签名，生成签名hello.sig
```
echo hello | gmssl sm9sign -key alice.pem -pass 1234  -out hello.sig
```

使用主公钥sign_mpk.pem对签名数据进行验签
```
echo hello | gmssl sm9verify -pubmaster sign_mpk.pem -id alice -sig hello.sig
```

### SM9加密解密

初始化生成SM9 主公钥enc_mpk.pem、主私钥enc_msk.pem
```
gmssl sm9setup -alg sm9encrypt -pass 1234 -out enc_msk.pem -pubout enc_mpk.pem
```

使用主私钥生成用户bob的用户私钥bob.pem，并使用outpass参数指定的口令加密

```
gmssl sm9keygen -alg sm9encrypt -in enc_msk.pem -inpass 1234 -id bob -out bob.pem -outpass 1234
```

使用主公钥以及用户bob的id进行加密，生成加密文件hello.der

```
echo hello | gmssl sm9encrypt -pubmaster enc_mpk.pem -id bob -out hello.der
```

使用用户bob的私钥对加密文件进行解密

```
gmssl sm9decrypt -key bob.pem -pass 1234 -id bob -in hello.der
```

## ZUC算法

### ZUC加密解密

由于ZUC算法是对称加密算法，所以加密解密的操作是一样的。

设置ZUC算法加密所需的秘钥和IV
```
KEY=11223344556677881122334455667788
IV=11223344556677881122334455667788
```

使用秘钥和IV对数据进行加密和解密

```
echo hello | gmssl zuc -key $KEY -iv $IV -out zuc.bin
gmssl zuc -key $KEY -iv $IV -in zuc.bin
```


## CA

### 根CA自签发证书

首先生成CA根证书私钥rootcakey.pem，然后进行自签名，生成根证书rootcacert.pem 

```
gmssl sm2keygen -pass 1234 -out rootcakey.pem
gmssl certgen -C CN -ST Beijing -L Haidian -O PKU -OU CS -CN ROOTCA -days 3650 -key rootcakey.pem -pass 1234 -out rootcacert.pem -key_usage keyCertSign -key_usage cRLSign
```

查看生成的自签名证书rootcacert.pem 

```
gmssl certparse -in rootcacert.pem
```

### 根CA签发二级CA证书

首先生成二级CA的证书私钥，然后生成证书请求careq.pem，然后由根CA进行签名，生成二级CA的证书cacert.pem
```
gmssl sm2keygen -pass 1234 -out cakey.pem
gmssl reqgen -C CN -ST Beijing -L Haidian -O PKU -OU CS -CN "Sub CA" -days 3650 -key cakey.pem -pass 1234 -out careq.pem
gmssl reqsign -in careq.pem -days 365 -key_usage keyCertSign -path_len_constraint 0 -cacert rootcacert.pem -key rootcakey.pem -pass 1234 -out cacert.pem
```

查看生成的二级CA证书cacert.pem

```
gmssl certparse -in cacert.pem
```

### 二级CA签发用户证书 

首先生成用户私钥，并通过用户私钥生成证书请求encreq.pem，然后由二级CA进行签发，生成用户证书enccert.pem
```
gmssl sm2keygen -pass 1234 -out enckey.pem
gmssl reqgen -C CN -ST Beijing -L Haidian -O PKU -OU CS -CN localhost -days 365 -key enckey.pem -pass 1234 -out encreq.pem
gmssl reqsign -in encreq.pem -days 365 -key_usage keyEncipherment -cacert cacert.pem -key cakey.pem -pass 1234 -out enccert.pem
```

查看生成的用户证书enccert.pem

```
gmssl certparse -in enccert.pem
```

将二级CA的证书和用户证书放在一个文件中，形成完整的用户证书文件certs.pem

```
cat enccert.pem > certs.pem
cat cacert.pem >> certs.pem
```

## 数字证书


### 生成自签名证书

生成证书公私钥对，然后使用certgen命令生成自签名证书cert.pem
```
gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem

gmssl certgen -C CN -ST Beijing -L Haidian -O PKU -OU CS -CN Alice -days 365 -key sm2.pem -pass 1234 \
  -key_usage "digitalSignature" -key_usage "keyCertSign" -key_usage cRLSign \
  -out cert.pem
```

### 解析数字证书

```
gmssl certparse -in cert.pem
```

## CMS


### CMS加密


使用数字证书cert.pem（数字证书的生成可以参考[[#生成自签名证书]]或者CA相关部分）对plain.txt文件进行加密，生成加密文件enveloped_data.pem

```
gmssl cmsencrypt -in plain.txt -rcptcert cert.pem -out enveloped_data.pem
```

### CMS解密

使用私钥key.pem对enveloped data进行解密

```
gmssl cmsdecrypt -key key.pem -pass 1234 -cert cert.pem -in enveloped_data.pem
```

### CMS签名

使用证书cert.pem对plain.txt进行签名，输出为signed_data.pem

```
gmssl cmssign -key key.pem -pass 1234 -cert cert.pem -in plain.txt -out signed_data.pem
```

### CMS验签

验证signed_data.pem，原始数据输出到signed_data.txt

```
gmssl cmsverify -in signed_data.pem -out signed_data.txt
```
### CMS解析

解析CMS签名数据signed_data.pem

```
gmssl cmsparse -in signed_data.pem
```

## PBKDF2算法

使用PBKDF2算法，对password 1234 和salt进行6000次哈希计算

```
gmssl pbkdf2 -pass 1234 -salt 1122334455667788 -iter 60000 -outlen 16
```