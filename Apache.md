# Apache #

## 版本：sh4twbox Arch Linux版 ##
### 安裝 ###
  * Apache 2.2
```
 # pacman -Syu
 # pacman -S apache
```
### 設定 ###
  * 修改主設定檔 /etc/httpd/conf/httpd.conf
> > 先備份
```
  # cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.original
```
> > 下面的sh4twbox 可以改成自己的網址
```
  # sed -i 's/#ServerName www.example.com:80/ServerName sh4twbox:80/g' /etc/httpd/conf/httpd.conf
  # sed -i "s,LoadModule unique_id_module modules/mod_unique_id.so,#LoadModule unique_id_module modules/mod_unique_id.so,g" /etc/httpd/conf/httpd.conf
```

  * 網頁資料夾位置：/srv/http/

  * 預設首頁檔案：index.html

### 開機啟用 ###
```
 # echo "/etc/rc.d/httpd start" >> /etc/rc.local
```