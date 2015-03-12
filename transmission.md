# transmission 是一套可遠端操控的BT(p2p)套件 #

## 版本：sh4twbox Arch Linux 版 ##
```
 # yaourt -S transmission-cli
```
_因為還沒導入systemd造成下列的錯誤訊息可以忽略，實際上檔案已經裝好了。_

|/tmp/alpm\_BB5CXU/.INSTALL: line 10: systemd-tmpfiles: command not found|
|:-----------------------------------------------------------------------|

  * https://wiki.archlinux.org/index.php/Transmission
  * 預設設定檔：/var/lib/transmission/.config/transmission-daemon/settings.json
> |更改設定檔前，請輸入 ps -aux|grep transmission 確定沒有 /usr/bin/transmission-daemon |
|:--------------------------------------------------------------------------------------------------|
  * 預設使用者：transmission
### 更改使用者 ###
```
 # vi /etc/conf.d/transmissiond
-----------------------------------
 TRANS_USER="[帳號]"
```
### 手動啟動 ###
> 啟動
```
 # /etc/rc.d/transmissiond start
```
> 停止
```
 # /etc/rc.d/transmissiond start
```
> 重啟動
```
 # /etc/rc.d/transmissiond restart
```
> 重新載入設定檔
```
 # /etc/rc.d/transmissiond reload
```

### 開啟啟動 ###
```
 # vi /etc/rc.conf
```

> 最底下DAEMONS中增加transmissiond
```
 DAEMONS=( ... transmissiond)
```


---

## 版本：sh4twbox shpkg版 ##

1.安裝transmission
```
 $ shpkg -S transmission-cli
```

2.檢查相依性，如需安裝，請按Enter讓他相關套件。
```
 $ shpkg -E
```

3.編輯 transmission daemon，預設是下載路徑和設定檔放再同一個資料夾裡面，我習慣把設定檔放到/etc下。你想也可以改到你自己想放的路徑
```
 # vi /etc/init.d/transmission-daemon
-------------------------------------------
TRAMSMISSION_DAEMON_OPTS=”-g /etc/transmission”  #set for transmission folder (setting & seed)
```
4.試著讓它啟動看看，順便首次執行產生設定檔，讓你可以進行修改。
```
 # /etc/init.d/transmission-daemon start
```

```
 # /etc/init.d/transmission-daemon stop
```

5.修改 transmission設定檔 (範例用的設定檔路徑為/etc/transmission)
```
 # vi /etc/transmission/settings.json
```
  * 主要設定項目為
  * "rpc-whitelist-enabled": false,
  * "download-dir": "[預設下載路徑]",
  * "incomplete-dir": "[預設下載路徑]",

6.在/etc/rc.local加入/etc/init.d/transmission-daemon start，讓開機自動啟動。
```
 # echo "/etc/init.d/transmission-daemon start" >> /etc/rc.local
```

7.正常啟動後，請用瀏覽器連至 http://[ip]:9091 就可看到遠端操控的UI了。