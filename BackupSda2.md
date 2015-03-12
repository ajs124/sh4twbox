# 將正常系統開機區sda2 打包成Recovery區sda1的 target.tgz #

使用時機:
網樂通按住Reset鈕並接上電源,前方指示燈 閃三下後自動回復sda1內的target.tgz到sda2

可使用sh4twbox 內建功能或者手動下命令去變更


# 選擇 sh4twbox第六項 #
root@sh4twbox ~ # sh4twbox

=== sh4twbox v0.6.2 MENU ===  boot from /dev/sda2
  1. Shell (default)

> 2) Set Time

> 3) Backup

> 4) install sh4TwBox to device (/dev/sda1:backup, /dev/sda2:normal)

> 5) install force overwrite

> 6) pack sda2 to sda1/target.tgz as the RESET restoring image

> 7) format partition

> 8) Restore

> 9) Upgrade from old sh4twbox to newer version on current root

============ Please Enter Number:

請選擇 6) pack sda2 to sda1/target.tgz as the RESET restoring image

會等上好長一段時間在執行 tar cvzf /mnt/sda1/target.tgz mnt\_system

這時候應該不能中斷,必須等到target.tgz完成.

Pack DONE. 會重回Menu.


# 分步驟手動下命令 #
透過usb儲存sda2到target.tgz所產生的檔案.

root@sh4twbox ~ # mkdir Temp

root@sh4twbox ~ # mount /dev/sdb1 /root/Temp

root@sh4twbox ~ # mount /dev/sda2 /mnt\_system

root@sh4twbox ~ # tar cvzf /root/Temp/target.tgz /mnt\_system

root@sh4twbox ~ # mount /dev/sda1 /tmp

root@sh4twbox ~ # rm /tmp/target.tgz

root@sh4twbox ~ # cp /root/Temp/target.tgz /tmp

完成