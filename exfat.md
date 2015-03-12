# Exfat 為 Windows下常見的儲存格式，多應用於大於32G的隨身碟/記憶卡裝置 #

## 版本：sh4twbox Arch Linux 版（方法一：建議） ##
### 安裝 ###
```
 # pacman -Syu
 # pacman -S fuse-exfat
```


## 版本：sh4twbox shpkg版(2.6.23.17-5) & archlinux版（方法二） ##

1.先下載exfat套件以及fuse kernel module
```
  $ wget http://sh4twbox.googlecode.com/files/fuse-exfat-1.0.1-sh4.tar.gz

  $ wget http://sh4twbox.googlecode.com/files/fuse-ko.tar.gz
```

2.把exfat套件解壓縮至根目錄，fuse kernel module解壓縮到/usr/modules目錄
```
  $ tar xzvf fuse-exfat-1.0.1-sh4.tar.gz -C /

  $ tar xzvf fuse-ko.tar.gz -C /usr/modules/

  $ sync
```

3.載入fuse kernel module，可用lsmod去檢查是否正確載入
```
  $ insmod /usr/modules/fuse.ko

  $ lsmod

  ->Module                  Size  Used by    Not tainted

  ->fuse                   41364  0
```
4.插入Exfat格式化的隨身碟，利用mount.exfat掛載
```
  $ mount.exfat -o iocharset=utf8 /dev/sdb1 /mnt/sdb1
```

5.利用df去檢查是否掛載成功
```
  $ df

  ->Filesystem           1K-blocks      Used Available Use% Mounted on

  ->/dev/root              7411688    812068   6449020  11% /

  ->/dev/sdb1              xxxxxxx   xxxxxxx   xxxxxx   0% /mnt/sdb1
```
6.確定可以正常存取隨身碟後，可以把第三步的指令加入/etc/rc.local裡，讓sh4twbox自動載入fuse module
```
  $ echo "insmod /usr/modules/fuse.ko" >> /etc/rc.local
```

7.格式化的方法(請先利用$ `fdisk -l`去找出你隨身碟的dev位置，通常為/dev/sdb1)
```
  $ mkfs.exfat /dev/sdb1 
```