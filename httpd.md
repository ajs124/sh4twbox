# httpd是busybox內建的http服務，讓你不用安裝其他套件，就可以直接開啟http服務 #
  * busybox的httpd頗強大，已經內建CGI，還可以過濾ip和認證登入的功能。


## 版本：sh4twbox shpkg版 ##

1. $ `/sbin/httpd -p 80 -h /root/public -c /etc/httpd.conf`
  * -p後面加的是你要開啟的port，如果你不加此參數，預設是80
  * -c是httpd參考config檔的參數，後面直接加你httpd config檔的路徑即可，可以不加此參數也可以啟動服務，但是config可以讓你的http服務更彈性。(後面會解說)
  * -h是http服務的根目錄。可以不加，不加的話你就一定要-c參考config檔，然後在裡面加入預設根目錄的設定。
  * -f這個參數加了，就會讓你的httpd不要daemon化(就是前景執行，你的命令列會被拉住)
  * 其他參數，請打入 $ `httpd --h`，就會列給你。

2.要停止httpd服務，也很簡單。
> $ `killall httpd`

3. CGI script預設的目錄路徑是相對於http根目錄下的/cgi-bin。
  * 如果你的httpd啟動時，設了-h /root/public。
  * 這樣你的CGI script就要丟到 /root/public/cgi-bin下面
  * 此外你要跑的script權限要改成"可執行"，至少要700
    * $ `chmod 700 /root/public/cgi-bin/*.cgi`

4. httpd.conf的設定可以參考 [這裡](http://wiki.chumby.com/index.php?title=Using_the_busybox_HTTP_server) 和 [這裡](http://wiki.openwrt.org/doc/howto/http.httpd)
> $ `vi /etc/httpd.conf`
  * 這個我寫的範例供大家參考，[點我](http://paste.ubuntu.com/5612820/)
  * #是註解，後面的東西都會被忽略
  * H:/root/public     # http服務的根目錄
  * I:index.html       # 如果瀏覽的目錄下有index.html檔，去讀它。
  * A:`*`                # 允許所有ip訪問
  * /cgi-bin:foo:bar   # 要訪問/cgi-bin路徑時，需要用foo/bar登入。
    * foo是帳號，bar是密碼，/cgi-bin是相對於http根目錄的路徑。
    * 密碼可以是明碼或是MD5暗碼。
      * 如要產生 MD5，可用 $ `httpd -m [password]` 來產生
      * 譬如 $ `httpd -m bar` 執行完，螢幕顯示 $1$6YUQQMFR$qT7cqg.UHH8ieYXDK/hUe0
      * 改設為 /cgi-bin:foo:$1$6YUQQMFR$qT7cqg.UHH8ieYXDK/hUe0

5. 如果要加入php和mysql，還要額外安裝其他套件

6. 如果想要有檔案清單的功能像[這個](http://linux.dell.com/repo/)，或許可以用cgi或是php的方式去實現? 但是想更快速完成，請改裝lighttpd 或是其他http 套件。
  * lighttpd有內建檔案列表的選項可以直接enable