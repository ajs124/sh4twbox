# NFS (Network File System) #
透過網路讓不同的機器、不同的作業系統能夠彼此分享個別的資料（kernel 需支援 NFS4）

[Wikipedia:NFS](http://zh.wikipedia.org/wiki/%E7%BD%91%E7%BB%9C%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F)

Windows 需企業版才有提供連接功能。

## 版本：sh4twbox Arch Linux版 ##
檢查檔案衝突
```
 # pacman -Qo /usr/bin/rpcinfo
```
如果顯示屬於 busybox，
則先移動到 /root 放置
```
 # mv /usr/bin/rpcinfo /root/rpcinfo_usr_bin
```
### 安裝 ###
```
 # pacman -S nfs-utils
```
[設定參考：Archlinux wiki:NFS](https://wiki.archlinux.org/index.php/Nfs)

### Server 設定 ###
  1. 修改vi/etc/idmapd.conf內的 Domain 為自己的網域名稱
```
 # vi /etc/idmapd.conf
------------------------------------------------
[General]
 
Verbosity = 1
Pipefs-Directory = /var/lib/nfs/rpc_pipefs
Domain = myhome

[Mapping]

Nobody-User = nobody
Nobody-Group = nobody
```

2. 建立NFS目錄
```
    # mkdir /srv/nfs4  ## 作為NFS 的根目錄
    # mkdir /srv/nfs4/music  ##要開放供連接的目錄
    # mount --bind /mnt/music /srv/nfs4/music  ##將要開放的 /srv/nfs4/music 連接到 /mnt/music
```
> 開機時掛載
```
 # vi /etc/fstab
---------------------------------------------
/mnt/music /srv/nfs4/music  none   bind   0   0

```

3. 編輯 /etc/exports，設定開放給 192.168.0.x
```
 # vi /etc/exports
--------------------------------------------------------
/srv/nfs4/ 192.168.0.1/24(rw,fsid=root,no_subtree_check)
/srv/nfs4/music 192.168.0.1/24(rw,no_subtree_check,nohide)
```
如果 NFS-server 已啟動則手動更新
```
 # exportfs -rav
```

4. 啟動service
```
 # /etc/rc.d/rpcbind start
 # /etc/rc.d/nfs-common start
 # /etc/rc.d/nfs-server start
```
開機時自動啟動
```
 # echo "/etc/rc.d/rpcbind start" >> /etc/rc.local
 # echo "/etc/rc.d/nfs-common start" >> /etc/rc.local
 # echo "/etc/rc.d/nfs-server start" >> /etc/rc.local
```
### Linux Client 連接 ###
列出可連接目錄：
```
 # showmount -e [主機名稱或IP]
```
連接NFS-server上的 /srv/nfs4/music 到本機的 /mnt/music
(Nfs-server端設定 fsid=root 所定義的目錄直接當成 /)
```
 # mount -vt nfs4 [主機名稱或IP]:/music /mnt/music
```