# gmssl命令行工具介绍

GmSSL支持的命令可以通过`GmSSL --help`来查看，如下所示：
```
gmssl@ubuntu:~/GmSSL/demos$ gmssl help
usage: gmssl command [options]

Commands:
  help            Print this help message
  version         Print version
  rand            Generate random bytes
  sm2keygen       Generate SM2 keypair
  sm2sign         Generate SM2 signature
  sm2verify       Verify SM2 signature
  sm2encrypt      Encrypt with SM2 public key
  sm2decrypt      Decrypt with SM2 private key
  sm3             Generate SM3 hash
  sm3hmac         Generate SM3 HMAC tag
  sm4             Encrypt or decrypt with SM4
  zuc             Encrypt or decrypt with ZUC
  sm9setup        Generate SM9 master secret
  sm9keygen       Generate SM9 private key
  sm9sign         Generate SM9 signature
  sm9verify       Verify SM9 signature
  sm9encrypt      SM9 public key encryption
  sm9decrypt      SM9 decryption
  pbkdf2          Generate key from password
  reqgen          Generate certificate signing request (CSR)
  reqsign         Generate certificate from CSR
  reqparse        Parse and print a CSR
  crlparse        Parse and print CRL
  certgen         Generate a self-signed certificate
  certparse       Parse and print certificates
  certverify      Verify certificate chain
  cmsparse        Parse cryptographic message syntax (CMS)
  cmsencrypt      Generate CMS EnvelopedData
  cmsdecrypt      Decrypt CMS EnvelopedData
  cmssign         Generate CMS SignedData
  cmsverify       Verify CMS SignedData
  sdfutil         SDF crypto device utility
  skfutil         SKF crypto device utility
  tlcp_client     TLCP client
  tlcp_server     TLCP server
  tls12_client    TLS 1.2 client
  tls12_server    TLS 1.2 server
  tls13_client    TLS 1.3 client
  tls13_server    TLS 1.3 server
```

## version     

功能：

查看gmssl的版本

示例：

```
gmssl version
```

## rand        

功能：

生成随机数

示例：

```
gmssl rand
```

## sm2keygen   

功能：

生成SM2公私钥对

参数：

-pass 加密生成的SM2私钥所用的口令

-out 生成的SM2私钥

-pubout 生成的SM2公钥

示例：

```
gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem
```

## sm2sign 

功能：

使用SM2私钥进行签名，可以队文件进行签名，也可以使用管道进行签名

参数：


-key SM2私钥

-pass SM2私钥的加密口令

-id 指定签名使用的的ID（可选项，默认为1234567812345678）

-in 待签名文件

-out SM2签名结果

示例：

```
gmssl sm2sign -key sm2.pem -pass 1234 -in data.txt -out sm2.sig 
echo hello | gmssl sm2sign -key sm2.pem -pass 1234 -out sm2.sig 
gmssl sm2sign -key sm2.pem -pass 1234 -in data.txt -out sm2.sig -id 1234567812345678
echo hello | gmssl sm2sign -key sm2.pem -pass 1234 -out sm2.sig -id 1234567812345678
```

## sm2verify   

功能：

使用公钥或者数字证书，对相应数据的SM2签名值进行验证

参数：

-pubkey 公钥

-cert 数字证书

-id 签名值使用的ID

-in 待验证的原始数据

-sig 待验证的签名值

示例：

```
gmssl sm2verify -pubkey sm2pub.pem -in data.txt -sig sm2.sig -id 1234567812345678
echo hello | gmssl sm2verify -pubkey sm2pub.pem -sig sm2.sig -id 1234567812345678
```

## sm2encrypt  

功能：

使用SM2公钥或者数字证书对数据进行加密

参数：

-pubkey 公钥

-cert 数字证书

-in 待加密数据

-out SM2加密结果

示例：

```
gmssl sm2encrypt -pubkey sm2pub.pem -in data.txt -out sm2.der
echo hello | gmssl sm2encrypt -pubkey sm2pub.pem -out sm2.der
```

## sm2decrypt  

功能：

使用SM2私钥对加密数据进行解密

参数：

-key 私钥

-pass 私钥口令

-in 待解密数据

-out 解密结果

示例：

```
gmssl sm2decrypt -key sm2.pem -pass 1234 -in sm2.der
```

## sm3  

功能：

计算数据的SM3哈希值

参数：

-pubkey SM2公钥

-id SM2公钥对应的ID

-bin 以2进制输出

-hex 以16进制输出

-in 待计算数据

-out 计算结果

示例：

```
echo -n abc | gmssl sm3

gmssl sm2keygen -pass 1234 -out sm2.pem -pubout sm2pub.pem
echo -n abc | gmssl sm3 -pubkey sm2pub.pem -id 1234567812345678
```

## sm3hmac     

功能：

使用SM3算法和key计算数据的HMAC值

参数：

-key 私钥

-bin 以2进制输出

-hex 以16进制输出

-in 待计算数据

-out 计算结果

示例：

```
echo -n abc | gmssl sm3hmac -key 11223344556677881122334455667788
```

## sm4  

功能：

使用SM4算法进行加密和解密，可以使用文件输入或者管道输入

参数：

-key SM4加密解密使用的长度为128bit的key，使用16进制表示

-iv SM4加密使用的IV

-encrypt 进行加密

-decrypt 进行解密

-cbc 使用CBC模式

-ctr 使用CTR模式

-in 待加密/解密数据

-out 加密/解密结果 

示例：

```
KEY=11223344556677881122334455667788
IV=11223344556677881122334455667788

echo hello | gmssl sm4 -cbc -encrypt -key $KEY -iv $IV -out sm4.cbc
gmssl sm4 -cbc -decrypt -key $KEY -iv $IV -in sm4.cbc

echo hello | gmssl sm4 -ctr -encrypt -key $KEY -iv $IV -out sm4.ctr
gmssl sm4 -ctr -decrypt -key $KEY -iv $IV -in sm4.ctr
```

## zuc         

功能：

使用ZUC算法进行加密和解密

参数：

-key ZUC算法使用的长度为128bit的key，使用16进制表示

-iv ZUC使用的IV

-in 待加密/解密数据

-out 加密/解密结果 

示例：

```
KEY=11223344556677881122334455667788
IV=11223344556677881122334455667788

echo hello | gmssl zuc -key $KEY -iv $IV -out zuc.bin
gmssl zuc -key $KEY -iv $IV -in zuc.bin
```

## sm9setup   

功能：

生成SM9算法的主公钥和主私钥

参数：

-alg SM9密钥的用途，可选项包括，sm9/sm9sign/sm9keyagreement/sm9encrypt

-pass 主私钥加密口令

-out 生成的主私钥

-pubout 生成的主公钥

示例：

```
gmssl sm9setup -alg sm9sign -pass 1234 -out sign_msk.pem -pubout sign_mpk.pem
```

## sm9keygen   

功能：

通过主私钥生成用户的SM9密钥

参数：

-alg SM9密钥的用途，可选项包括，sm9/sm9sign/sm9keyagreement/sm9encrypt

-in 使用的主私钥

-inpass 主私钥的加密口令

-id 用户id

-out 用户的私钥

-outpass 用户私钥的加密口令

示例：

```
gmssl sm9keygen -alg sm9sign -in sign_msk.pem -inpass 1234 -id alice -out alice.pem -outpass 1234
```


## sm9sign 

功能：

通过用户SM9私钥对数据进行签名

参数：

-key 用户SM9私钥

-pass 用户SM9私钥的加密口令

-in 待签名数据

-out 签名结果

示例：

```
echo hello | gmssl sm9sign -key alice.pem -pass 1234  -out hello.sig
gmssl sm9sign -key alice.pem -pass 1234 -in data.txt  -out hello.sig
```


## sm9verify   

功能：

通过SM9主公钥及用户id对签名值进行验签

参数：

-pubmaster 主公钥 

-id 用户id

-sig 待验证签名

-in 原始数据

示例：

```
echo hello | gmssl sm9verify -pubmaster sign_mpk.pem -id alice -sig hello.sig
gmssl sm9verify -pubmaster sign_mpk.pem -id alice -in data.txt -sig hello.sig
```

## sm9encrypt  

功能：

通过SM9主公钥及用户id对数据进行加密，此处使用的主公钥在生成时应指定为sm9encrypt

参数：

-pubmaster 主公钥 

-id 用户id

-in 原始数据

-out 加密结果

示例：

```
echo hello | gmssl sm9encrypt -pubmaster enc_mpk.pem -id bob -out hello.der
gmssl sm9encrypt -pubmaster enc_mpk.pem -id bob -in data.txt -out hello.der
```

## sm9decrypt  

功能：

通过对应的用户私钥对加密数据进行解密

参数：

-key 用户私钥 

-pass 用户私钥加密口令

-in 加密数据

-out 解密结果

示例：

```
gmssl sm9decrypt -key bob.pem -pass 1234 -id bob -in hello.der -out decrypt.txt
```

## pbkdf2      

功能：

PBKDF2算法，通过多次hash来对密码进行加密。原理是通过password和salt进行hash，然后将结果作为salt在与password进行hash，多次重复此过程，生成最终的密文。

示例：

```
gmssl pbkdf2 -pass 1234 -salt 1122334455667788 -iter 60000 -outlen 16
```

## reqgen      

功能：

通过私钥生成证书请求，可以指定证书请求的口令

示例：

```
gmssl reqgen -C CN -ST Beijing -L Haidian -O PKU -OU CS -CN Alice -days 365 -key signkey.pem -pass 1234 -out signreq.pem
```


## reqsign     


功能：

使用CA 私钥对用户的证书请求进行签发，生成签名后的数字证书，如果CA的私钥有加密口令，则需要通过-pass参数指定对应的加密口令

参数：

-in 待签名的证书请求

-days 证书有效期

-key_usage 证书用户

-cacert ca的证书

-key ca的私钥

-pass ca私钥的加密口令

-out 签名输出结果

示例：
```
gmssl reqsign -in signreq.pem -days 365 -key_usage digitalSignature -cacert cacert.pem -key cakey.pem -pass 1234 -out signcert.pem
```

## reqparse   


功能：

解析数字证书请求

参数：

-in 待解析的数字证书请求

-out 输出结果（可选，如果不指定则输出到屏幕）

示例：

```
gmssl reqparse -in alice.req
```

## crlparse    

功能：

解析证书吊销列表

参数：

-in 待解析的证书吊销列表

-out 输出结果（可选，如果不指定则输出到屏幕）

示例：

```
gmssl crlparse -in alice.crl
```

## certgen  

功能：

生成自签名SM2证书，一般用于根CA签发自己的数字证书

参数：

-C 证书的国家

-ST 证书的省份

—O 证书的Organization

-OU 证书的organization Unit

-CN 证书的Common Name

-days 证书有效期

-key SM2私钥

-pass SM2私钥加密口令

-out 生成的自签名证书

示例：

```
gmssl certgen -C CN -ST Beijing -L Haidian -O PKU -OU CS -CN Alice -days 365 -key key.pem -pass 1234 -out cert.pem
```

## certparse   

功能：

解析数字证书

参数：

-in 待解析的证书

-out 输出结果（可选，如果不指定则输出到屏幕）

示例：

```
gmssl certparse -in rootcacert.pem
```

## certverify  

功能：

通过CA证书验证数字证书的有效性

参数：

-in 待验证的证书

-cacert CA证书

示例：

```
gmssl certverify -in alice.pem -cacert rootcacert.pem
```

## cmsparse   

功能：

解析CMS数据（加密或者签名数据）

参数：

-in 待解析的CMS数据

示例：

```
gmssl cmsparse -in signed_data.pem
```

## cmsencrypt  

功能：

使用SM2数字证书对数据进行加密

参数：

-in 待加密数据

-rcptcert 加密使用的数字证书

-out 加密结果

示例：

```
gmssl cmsencrypt -in plain.txt -rcptcert cert.pem -out enveloped_data.pem
```

## cmsdecrypt  

功能：

使用SM2数字证书及对应的SM2私钥对数据进行解密

参数：

-key SM2私钥

-pass SM2私钥的加密口令

-cert 对应的数字证书

-in 待解密数据

-out 解密结果（可选，如果不指定则输出到屏幕）

示例：

```
gmssl cmsdecrypt -key key.pem -pass 1234 -cert cert.pem -in enveloped_data.pem
```

## cmssign    

功能：

使用SM2私钥及证书对数据进行签名

参数：

-key SM2私钥

-pass SM2私钥的加密口令

-cert 对应的数字证书

-in 待签名数据

-out 解密结果

示例：

```
gmssl cmssign -key key.pem -pass 1234 -cert cert.pem -in plain.txt -out signed_data.pem
```

## cmsverify   

功能：

使用SM2私钥及证书对数据进行签名

参数：

-key SM2私钥

-pass SM2私钥的加密口令

-cert 对应的数字证书

-in 待签名数据

-out 解密结果

示例：

```
gmssl cmsverify -in signed_data.pem -out signed_data.txt
```

## sdfutil     
## skfutil     
## tlcp_client 
## tlcp_server 
## tls12_client
## tls12_server
## tls13_client
## tls13_server
