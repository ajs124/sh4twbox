# crond是一支排程的程式，可以讓系統定時重複做同樣的事情 #

## 版本：sh4twbox shpkg 0.6.2版 ##

1.sh2twbox用的是busybox內建的crond，啟動的daemon，已經預設在/etc/init.d裡，0.6.2版的系統也預設開機自動啟動。(0.5.1版不確定是否有設開機啟動)

2.然而crond會去讀取一個叫crontab的東西去告訴系統要排程哪些事情。因此我們只要很簡單的去把我們要做的事情丟到crontab裡面即可。

3.要編輯crontab很簡單，只要打 $ `crontab -e` 即可進入編輯畫面(編輯器是用內建預設的vi)
> $ `crontab -e`

4.在crontab裡面新增任務需要依照他的格式。 詳細可參考 [這裡](http://linux.vbird.org/linux_basic/0430cron.php#crontab)

簡單說明一下

#分  時  日  月  週  |<==============指令串========================>|
> 0   0   `*`   `*`   `*`  /etc/init.d/ushare retstart  #每天00:00重新啟動ushare

> `*`   `*`/5 `*`   `*`   `*`  rm -rf ~/tmp/   #每五個小時清空家目錄下的tmp資料夾

  * #代表的是註解，所以#後面的文字都會被忽略
  * 每個欄位都要以tab鍵隔開，不能只是空白。
  * 如果以(tab)表示tab鍵，正確格式應該會變成以下
> 0 (tab) 0 (tab) `*` (tab) `*` (tab) `*` (tab) /etc/init.d/ushare retstart #每天00:00重新啟動ushare
  * 每個使用者都有自己一張crontab，所以你所編輯crontab裡的任務就是由你所登入的帳號去執行，因此如果你不是用root登入，去新增一個只能由root去執行的檔案，是會錯誤的。(錯誤訊息你看不到，可能會寫在log裡，然後執行的動作會失效)

5.編輯完就可以 `[`esc`]` :wq存檔離開vi介面了。 此時要檢查你所編輯的corntab內容
> $ `crontab -l`

6.確認無誤後，重新開機去讓crond去讀取你新的crontab
> $ `reboot`

7.每個帳號的crontab都位於/var/spool/cron/crontabs/下面，以帳號命名，不過都無法存取，唯一能存取crontab的方法只要用 $ `crontab`指令