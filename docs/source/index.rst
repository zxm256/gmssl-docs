GmSSL开发文档
===================================

GmSSL是一个开源的密码工具箱，支持SM2/SM3/SM4/SM9/ZUC等国密(国家商用密码)算法、SM2国密数字证书及基于SM2证书的SSL/TLS安全通信协议，支持国密硬件密码设备，提供符合国密规范的编程接口与命令行工具，可以用于构建PKI/CA、安全通信、数据加密等符合国密标准的安全应用。GmSSL项目是OpenSSL项目的分支，并与OpenSSL保持接口兼容。因此GmSSL可以替代应用中的OpenSSL组件，并使应用自动具备基于国密的安全能力。GmSSL项目采用对商业应用友好的类BSD开源许可证，开源且可以用于闭源的商业应用。

GmSSL项目由北京大学关志副研究员的密码学研究组开发维护，项目源码托管于GitHub。自2014年发布以来，GmSSL已经在多个项目和产品中获得部署与应用，并获得2015年度“一铭杯”中国Linux软件大赛二等奖(年度最高奖项)与开源中国密码类推荐项目。GmSSL项目的核心目标是通过开源的密码技术推动国内网络空间安全建设。



.. note::

   文档正在编写过程中

文档列表
--------

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   overview.md
   version.md
   hash/index
   hmac/index
   block_cipher/index
   random/index
   public_cipher/index
   identity_based_crypto/index
   encode_decode/index
   key_derive/index
   cert/index
   ssl/index
   about


