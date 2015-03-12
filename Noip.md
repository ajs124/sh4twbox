# No-ip Client #
(透過 no-ip.com 定時更新動態IP對應的網址)

## 版本：sh4twbox Arch Linux版 ##
### 安裝 ###
```
 # pacman -Syu
 # pacman -S noip
```

### 設定 ###
（過程中會詢問no-ip帳號、密碼、使用的網址、檢查ip更新間隔）
```
 # noip2 -C
```

### 啟動 ###
啟動並讀取設定檔 /etc/no-ip2.conf
```
 # noip2 -c /etc/no-ip2.conf
```
檢查有沒有啟動
```
 # ps -aux|grep noip
```
> 結尾有 noip2 -c /etc/no-ip2.conf 表示已啟動

開機自動啟動
```
 # echo "noip2 -c /etc/no-ip2.conf" >> /etc/rc.local
```

### 其他 ###
參考資料：[ArchLinuxWiki Noip](https://wiki.archlinux.org/index.php/Noip)

指令說明
```
 # noip2 -h
```