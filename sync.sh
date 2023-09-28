wget -O docs/source/multi_language/java.md https://raw.githubusercontent.com/GmSSL/GmSSL-Java/main/README.md
wget -O docs/source/multi_language/php.md https://raw.githubusercontent.com/GmSSL/GmSSL-PHP/main/README.md
wget -O docs/source/multi_language/python.md https://raw.githubusercontent.com/GmSSL/GmSSL-Python/main/README.md
wget -O docs/source/multi_language/go.md https://raw.githubusercontent.com/GmSSL/GmSSL-Go/main/README.md

time="同步时间: $(date "+%Y-%m-%d %H:%M:%S")"
echo $time >> docs/source/multi_language/java.md
echo $time >> docs/source/multi_language/php.md
echo $time >> docs/source/multi_language/python.md
echo $time >> docs/source/multi_language/go.md
