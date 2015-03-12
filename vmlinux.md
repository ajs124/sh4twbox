# 進階 - vmlinux.ub.opt3 是一個可降頻節能的vmlinux #
此檔案由[偽物筆記本 - oranqe](http://tinyurl.com/cmsdxv5)編譯提供

## 版本：sh4twbox shpkg版 arch版 皆適用 ##

1.先在網樂通上下載vmlinux.ub.opt3
> $ `wget http://sh4twbox.googlecode.com/files/vmlinux.ub.opt3 -O /vmlinux.ub.opt3`

2.用sync指令來確保檔案完整的寫入網樂通
> $ `sync`

3.修改vmlinux，在這裡使用的方法為sh4twbox預設方法一樣，用連結(symbolic link)的方式而非整個覆蓋檔案，此步驟重要，請確保順利完成。
> $ `rm /vmlinux.ub`

> $`ln -s /vmlinux.ub.opt3 /vmlinux.ub`

4.檢查步驟3是否正確，把根目錄詳細列出來，檢查symbolic link是否建立正確。
> $`ls -al /`
-> lrwxrwxrwx    1 root     root            15 Apr 26 13:31 vmlinux.ub -> vmlinux.ub.opt3

-> -rw-r--r--    1 root     root       3041584 Apr 26 13:23 vmlinux.ub.opt3
  * 確定vmlinux是否指向vmlinux.ub.opt3 ，且vmlinux.ub.opt3大小應該為3041584

5.步驟4確定無誤後，再重開機。(如果步驟3沒有完成就重開機，會開不了機)
> $ `reboot`

6.重開機後，我們先可以去查看CPU現在的使用時脈，他應該會顯示450000
> $ `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`

7.此時，我們可以修改CPU的scaling governor，改為conservative，然後再去查看CPU使用時脈，如果你沒在掛BT和傳檔案，應該就會降為112500了。
> $ `echo "conservative" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`

> $ `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`

8.但是每次重開機，CPU的scaling governor都會被reset，因次我們也是把指令加在/etc/rc.local裡，讓開機時直接啟用。
> $ `echo "echo “conservative” > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /etc/rc.local `

9. conservative CPU scaling的運作模式如下，因此當你的網樂通CPU loading不高時，會自動降頻已達省電的效果。(不過其實網樂通已經很省電了)
  * CPU Load : 00~30% ,112500 Hz
  * CPU Load : 30~50% ,225000 Hz
  * CPU Load : 50~100% ,450000 Hz