# ntfs為微軟訂定的一種硬碟格式 #

## 版本：sh4twbox Arch Linux 版 ##
安裝：
```
 # pacman -Syu #更新資料庫
 # pacman -S fuse ntfs-3g
```
使用方法：
```
 # mount -t ntfs-3g  /dev/sdxy /mnt/sdxy
```
user id =1000 的使用者可以讀寫，
讀檔案時不更新Access Time，
支援中文
```
 # mount -t ntfs-3g -o uid=1000,noatime,iocharset=utf8 /dev/sdxy /mnt/sdxy
```

## 版本：sh4twbox shpkg版 ##

1.安裝ntfs-3g即可
> $ `shpkg -S  mount.ntfs-3g`

> $ `shpkg -E`

2.掛載ntfs的硬碟
> $`mount.ntfs /dev/sdx /mnt/sdx`