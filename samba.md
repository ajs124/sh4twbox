# samba 是一套相容於Windows網路上芳鄰的遠端存取套件 #

## 版本：sh4twbox Arch Linux版 ##
### 安裝 ###
```
 # pacman -Syu
 # pacman -S samba
```
### 設定 ###
建立samba 使用者 root 並設定密碼
```
 # pdbedit -a -u root
```

## 版本：sh4twbox shpkg版 ##

1.安裝samba，此教學安裝的版本為sh4oldbox samba 3.5.8.sh4
```
 $ shpkg -S samba
```

2.檢查相依性，如需安裝，請按Enter讓他相關套件。
```
 $ shpkg -E
```

3.編輯samba的設定檔，相關設定請參考 [這裡](http://linux.vbird.org/linux_server/0370samba.php#server_smb.conf)
```
 # vi /etc/smb.conf
```

4.啟動前先設定root登入samba時所需的密碼 (連續輸入兩次，螢幕上不會顯示)
```
 # /usr/local/bin/smbpasswd –a
```

5.在/etc/init.d/samba start，讓開機自動啟動。
```
 # echo "/etc/init.d/samba start" >> /etc/rc.local
```

7.重開機後，就可以存取網樂通上的samba了。
  * `[`windows`]` : 在我的電腦上的路徑列打 "\\192.168.x.x" (此為你網樂通的ip) ，帳號打root，密碼為步驟4所設
  * `[`Linux`] `: Linux環境下存取samba方法眾多，請參照 [這篇](http://www.vixual.net/blog/archives/228)

8. 此版的samba (sh4oldbox samba 3.5.8.sh4) ，我一直試不出來用其他帳號登入的方法，如果跟我一樣試不出來，或許可以換一個版本的samba試看看。
  * fedora9 samba 3.2.7-0.23.fc9.sh4