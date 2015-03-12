# 教學 - 修改系統時區 #
## 版本：sh4twbox Arch Linux ##
原本就有 timezone &  tzselect 指令

## 版本：sh4twbox shpkg版 0.6.2 (含以下) ##

1.先用wget下載timezone.tar.gz到網樂通裡 (亦可用電腦下載，再丟進去網樂通裡)
> $ `wget http://sh4twbox.googlecode.com/files/timezone.tar.gz`

2.把它解壓縮到根目錄下 (他只會在/usr/share裡新增zoneinfo和取代掉/usr/bin/裡的tzselect，總大小大概5MB)
> $ `tar -xzvf timezone.tar.gz  -C /`

3.在~/.profile裡面加入你想設定的時區。(sh4twbox預設是沒這個檔案的)
> $ `echo "export TZ='Asia/Tokyo'" >> ~/.profile`

4.如果你不知道自己的時區代碼是什麼，可以用`tzselect`來查詢
> $ `tzselect`


mirror - http://dl.dropboxusercontent.com/sh/a6dqfm6a79fetn9/AciFGVb254/patch-timezone/timezone.tar.gz