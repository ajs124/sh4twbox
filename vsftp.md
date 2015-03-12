# vsftp #
## 版本：sh4twbox Arch Linux版 ##
### 安裝 ###
```
 # pacman -S vsftpd
```
啟動
```
 # /etc/xinetd.d/vsftpd &
```
  * https://wiki.archlinux.org/index.php/Vsftpd

### 更改設定檔 ###
```
 # vi /etc/vsftpd.conf
```
  * 取消匿名登入
```
  anonymous_enable=NO
```
  * 以系統內帳號登入（/etc/passwd）
```
  local_enable=YES
```
  * 開啟寫入功能
```
  write_enable=YES
```

### 開機啟動 ###
```
 # echo "/usr/bin/vsftpd &" >> /etc/rc.local
```

## 版本：sh4twbox shpkg版 ##

1.安裝vsftp
> $ `shpkg -S stlinux23-sh4-vsftpd`

2.檢查相依性，如需安裝，請按Enter讓他相關套件。
> $ `shpkg -E`

3.stlinux23版的vsftp沒有打包daemon，所以要自己建立一個vftpd
> $ `vi /etc/init.d/vsftpd`
#<<<<<<<<file : /etc/init.d/vsftpd<<<<<<<<<<<<<<<<#

#!/bin/sh

echo -n 'vsftpd'

case "$1" in

start)
> echo "Starting vsftpd ..."

> /usr/sbin/vsftpd &

> ;;
stop)
> echo "Stopping vsftpd ..."

> killall vsftpd

> ;;
`*`)
> echo "Usage: '$0' {start|stop}" >&2

> exit 64

> ;;
esac

exit 0

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#

4.修改新增daemon的權限，讓它executable(可執行)
> $ `chmod +x /etc/init.d/vsftpd`

5.建立安全帳戶的根目錄。
> $ `mkdir /usr/share/empty `

6.編輯vsftp的設定檔  (相關設定可參考 [這裡](http://linux.vbird.org/linux_server/0410vsftpd.php#server_vsftpd.conf))
> $ `vi /etc/vsftpd.conf`
主要修改的項目有以下
  * anonymous\_enable=NO
  * local\_enable=YES
  * write\_enable=YES
  * local\_umask=022
  * chroot\_local\_user=YES
  * check\_shell=NO
  * use\_localtime=YES
  * listen\_port=21   //default is 21

7. 試著啟動看看，以上的設定值可讓Linux內建的帳號都可以登入，登入目錄為自己的家目錄
> $ `/etc/init.d/vsftpd start`

8.在/etc/rc.local加入/etc/init.d/vsftpd start，讓開機自動啟動。
> $ `echo "/etc/init.d/vsftpd start" >> /etc/rc.local`

9.如果想建立多個帳號，存取同一個資料夾。可在/etc/passwd裡新增帳號，再用passwd去修改密碼。`[`UID`]`請指定一個2-65535間唯一的數字。
> $ `echo [帳號]:*:[UID]:501:ftp public access:[共用的資料夾]:/sbin/nologin » /etc/passwd`

> $ `passwd [帳號]`

10.如果只是想開一個匿名可登入的FTP，方便大家存取，可以不用裝vsftp，用內建busybox的ftpd
> $ `tcpsvd -vE 0.0.0.0 21 ftpd -w [/files/to/serve] &`
  * 21為port
  * -w為允許上傳
  * [/files/to/serve]為ftp登入存取的目錄
  * 其他相關參數請參照 $ `tcpsvd`和 $ `ftpd`
  * 要停止ftp，請輸入 $ `killall tcpsvd ftpd`