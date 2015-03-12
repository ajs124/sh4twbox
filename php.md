# PHP #
  * 此教學，分為for [busybox httpd](http://code.google.com/p/sh4twbox/wiki/httpd) 以及 [lighttpd](http://code.google.com/p/sh4twbox/wiki/lighttpd?ts=1367295755&updated=lighttpd)
  * 要服用本篇前，請先確定自己的http服務是正常的。

## 版本：sh4twbox shpkg版 ##

1. 安裝php相關的所有套件，大小大概40MB左右。
> $ `shpkg -S php php-cli php-gd php-common readline gmp libcurl bzip2-libs pcre ncurses-libs libidn openldap nss nspr cyrus-sasl-lib `

2. 檢查相依性，如需安裝，請按Enter讓他相關套件。 因為shpkg -E只能檢查第一層的相依性，所以請執行4~5次，確保所有相依套件都被安裝。
> $ `shpkg -E`

### ˙ for busybox httpd ###
3. 確定httpd服務是正常運作的。 [httpd教學](http://code.google.com/p/sh4twbox/wiki/httpd)

4. 安裝GD module相關套件
> $ `shpkg -S stlinux23-sh4-freetype`

> $ `shpkg -S stlinux23-sh4-libpng`

> $ `shpkg -S stlinux23-sh4-libjpeg`

5. 設定php.ini檔
> $ `echo "cgi.force_redirect = 0" >> /etc/php.ini`

> $ `echo "cgi.redirect_status_env ="yes";" >> /etc/php.ini`

6. 設定httpd config檔，把php指向正確的php執行檔。
> $ `echo "*.php:/usr/bin/php-cgi" >> /etc/httpd.conf`

7.重新啟動httpd 功能。(記得要-c 指向你有加入php啟動的config檔)
> $ `killall httpd`

> $ `/sbin/httpd -p 80 -h /root/public -c /etc/httpd.conf`

### ˙ for lighttpd ###

3. 確定lighttpd服務是正常運作的。[lighttpd教學](http://code.google.com/p/sh4twbox/wiki/lighttpd?ts=1367295755&updated=lighttpd)

4.設定php.ini檔
> $ `echo "cgi.fix_pathinfo = 1" >> /etc/php.ini`

5.設定lihttpd config檔，把php enable起來。
> $ `vi /etc/lighttpd/lighttpd.conf`
-------以下這段前面的#字號拿掉-------

"mod\_fastcgi",

fastcgi.server             = ( ".php" =>
> ( "localhost" =>
> > (
> > > "socket" => "/var/run/lighttpd/php-fastcgi.socket",


> "bin-path" => "/usr/bin/php-cgi"
> )
> )
> )

--------End of lighttpd.conf----------

6.重新啟動lihttpd
> $ `/etc/rc.d/init.d/lighttpd restart`