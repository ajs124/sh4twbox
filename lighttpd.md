# lighttpd是一套輕量級的http server套件 #
  * 此教學為fedora9 lighttpd 1.4.19-4.fc9.sh4版本
  * 使用上跟sh4oldbox lighttpd上略有差異，但方法類似。

## 版本：sh4twbox shpkg版 ##

1.首先先把shpkg設定檔裡面sh4oldbox package repo註解掉 (因為設定上sh4oldbox repo的修先度比fedora9 repo，如果直接安裝lighttpd，會裝到sh4oldbox版的)
  * $ `vi /etc/shpkg.conf  `  #把以下兩行前面加#字號
    * #sh4oldbox tgz http://sh4twbox.googlecode.com/files \
    * #       http://sh4twbox.googlecode.com/files \

2.更新shpkg package list
> $ `shpkg -Syy`

3.安裝lihttpd和 lighttpd-fastcgi套件
> $ `shpkg -S lighttpd lighttpd-fastcgi`

4.檢查相依性，如需安裝，請按Enter讓他相關套件。 因為shpkg -E只能檢查第一層的相依性，所以請執行4~5次，確保所有相依套件都被安裝。
> $ `shpkg -E`

5.lighttpd的設定檔預設在/etc/lighttpd/lighttpd.conf ，詳細教學可參考[這裡](http://tinyurl.com/cmh3usv)

列出一些基本的項目供大家快速設定(把前面的#字號移除，即為啟用)
  * "mod\_fastcgi",   #啟動fastcgi
  * server.port    = 80  #http要開啟的port，沒設就是80
  * dir-listing.activate  #開啟檔案列表功能 [像這個](http://linux.dell.com/repo/)
  * server.document-root = "/var/www/lighttpd/"  #http服務的根目錄
  * #指定CGI解譯程式 (.cgi預設是給perl解譯，如果沒安裝perl就指定空白也可，還是可以跑一些給sh跑的簡單script)
  * cgi.assign   = ( ".pl"  => "/usr/bin/perl",

> `#`             ".cgi" => "/usr/bin/perl" )

> ".cgi" => "")

6. 修改lighhtpd daemon，因為這是fedora 9 repo上的版本，所以有些東西跟網樂通的sh4twbox有些許差異，因此要修改一些東西。
> $ `vi /etc/rc.d/init.d/lighttpd`
  * #. /etc/rc.d/init.d/functions  #暫時不用去source這資料夾，所以前面加#註解掉
  * $lighttpd -f $LIGHTTPD\_CONF\_PATH  # start()裡面把daemon這個字移掉
  * killall lighttpd  #stop()裡面把killproc改成killall，並且把$lighttpd前面的$字號拿掉

7.增加一個lihttpd的使用者
> $ `echo lighttpd:*:40:40:lighttpd:/var/www/lighttpd:/bin/bash » /etc/passwd`

8.增加一個lighttpd的群組
> $ `echo lighttpd:*:40: » /etc/group`

9.修改log檔的權限，讓lighttpd使用者和群組可以讀寫
> $ `chown -R lighttpd.lighttpd /var/log/lighttpd`

> $ `chown -R lighttpd.lighttpd /var/run/lighttpd`

10.試著啟動lighttpd看看
> $ `/etc/rc.d/init.d/lighttpd start`

11.把它加到rc.local裡，讓開機自動啟用
> $ `echo "/etc/rc.d/init.d/lighttpd start" >> /etc/rc.local `

12.確定lighttpd安裝完成後，把一開始我們在shpkg設定檔裡，註解掉sh4oldbox的部份改回來
> $ `vi /etc/shpkg.conf`
    * sh4oldbox tgz http://sh4twbox.googlecode.com/files \
    * http://sh4twbox.googlecode.com/files \