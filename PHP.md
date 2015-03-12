# PHP #
## 版本：sh4twbox Arch Linux版 ##
### 安裝 ###
安裝 php 5.5 ( 需先安裝 Apache )
```
 # pacman -Syu
 # pacman -S php55
```
編輯 /etc/httpd/conf/httpd.conf
```
 # vi /etc/httpd/conf/httpd.conf
```
> LoadModule 最後新增一行
```
  LoadModule php5_module modules/libphp5.so 
```
> 首頁設定行增加 index.php
```
  DirectoryIndex index.html index.php
```
> TypesConfig conf/mime.types前加上 #
```
  #TypesConfig conf/mime.types
```
> 開啟支援cgi，拿掉#AddHandler cgi-script .cgi 前的 #
```
  AddHandler cgi-script .cgi
```
> 在<IfModule mime\_module>後新增2行
```
  AddType application/x-httpd-php .php .phtml 
  AddType application/x-httpd-php-source .phps
```
reboot 或 重啟apache 生效
```
 # apachectl restart
```

### 測試 ###
建立顯示php資訊網頁檔案
```
 # echo "<?php phpinfo(); ?>" > /srv/http/phpinfo.php
```
在網址輸入 http://[ip]/phpinfo.php 可以看到php設定資訊

### 編譯資訊 ###
```
./configure --prefix=/usr --with-config-file-path=/etc/php \
  --sbindir=/usr/bin --sysconfdir=/etc/php --localstatedir=/var\
  --with-layout=GNU --with-config-file-scan-dir=/etc/php/conf.d \
  --mandir=/usr/share/man \
  --with-apxs2=/usr/sbin/apxs --with-zlib-dir=/usr/lib \
  --with-mcrypt=/usr/lib --with-libxml-dir=/usr/lib \
  --with-mysql=shared --with-mysqli=/usr/bin/mysql_config \
  --with-mysql-sock=/tmp/mysql.sock \
  --with-jpeg-dir=/usr --with-png-dir=/usr \
  --with-gd --with-iconv  --with-zlib --enable-xml \
  --enable-bcmath --enable-shmop \
  --enable-sysvsem --enable-inline-optimization  \
  --enable-mbregex \
  --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl \
  --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap \
  --without-pear --with-gettext \
  --enable-session --with-mcrypt
```