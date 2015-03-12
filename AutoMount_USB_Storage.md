# 利用mdev自動掛載USB儲存裝置 #
在USB儲存裝置插入時，自動依系統名稱sdx掛載到 /media 。
預設使用在 kernel 2.6.32。

## 檢查 ##
  1. 確認使用mdev處理hotplug
```
 $ cat /proc/sys/kernel/hotplug
 /sbin/mdev
```
> 2. 確認出現新sdx裝置時會執行 /lib/mdev/usbdisk\_link
```
 $ cat /etc/mdev.conf|grep sd
 sd[a-z].*       root:disk 660 */lib/mdev/usbdisk_link
```

## 設定 ##
  1. 增加上一步查出的檔案 /lib/mdev/usbdisk\_link
```
 # mkdir /lib/mdev
 # vi /lib/mdev/usbdisk_link
```
> 寫入最後附的script。

> 2. 檢查kernel版本
```
 # uname -r
```
> 如果是2.6.23開頭，刪除兩行 #### 間的3行程式碼。兩行 ###### 之間程式碼取代成：
```
 mount -t auto -o sync /dev/${MDEV} ${mountdir}/${MDEV}
```
> 完成後輸入 :wq 存檔

> 3. 設定成可執行
```
 # chmod 700 /lib/mdev/usbdisk_link
```

## ArchLinux 加入 ntfs,exfat ##
```
 # pacman -Syu
 # pacman -S ntfs-3g fuse-exfat
```

## 遙控器`[i]`umount ##
> 用遙控器`[i]`按鈕umount 全部掛載到 /media 內的裝置
> 在 `/etc/lircrc` 加入
```
 begin                      
  button = KEY_INFO        
  prog   = irexec          
  repeat = 0               
  config = sync;for i in `find /media -name sd*`;do umount $i;done
  flags  = quit            
 end
```

或者是

```
 begin                      
  button = KEY_INFO        
  prog   = irexec          
  repeat = 0               
  config = sync;ls -1 /media |awk '{print i$0}' i='/media/' | xargs umount
  flags  = quit            
 end
```

## /lib/mdev/usbdisk\_link ##
參考來源：[Mdev/Automount USB/automount @ Gentoo Wiki](https://wiki.gentoo.org/wiki/Mdev/Automount_USB/automount)
```
#!/bin/busybox ash
#
remove_action () {
#
# Unmount the device.  The user should really unmount it before
# disconnecting
  umount ${1}
#
# Delete the directory in ${mountdir}
   rm -rf ${2}
}
# At bootup, "mdev -s" is called.  It does not pass any environmental
# variables other than MDEV.  If no ACTION variable is passed, exit
# the script.
#
# Execute only if the device already exists; otherwise exit
if [ ! -b ${MDEV} ] ; then exit 0 ; fi
#
# Make mountdir a var in case the pmount default directory ever changes
mountdir="/media"
#
# Flag for whether or not we have a partition.  0=no, 1=yes, default no
partition=0
#
# File descriptors 0, 1, and 2 are closed before launching this script.
# Many linux utilities are hard-coded to work with these file descriptors.
# So we need to manually open them.
0<  /dev/fd0
1>  /dev/fd1
#
# Note that the redirect of stderr to a temporary logfile in /dev/shm in
# append mode is commented out.  Uncomment if you want to debug problems.
# 2>> /dev/shm/mdev_err.txt
#
# Uncomment next line for debug data dump to /dev/shm/mdevlog.txt.
# env >> /dev/shm/mdevlog.txt
#
# Check for various conditions during an "add" operation
if [ "X${ACTION}" == "Xadd" ] ; then
#
# Flag for mounting if it's a regular partition
   if [ "X${DEVTYPE}" == "Xpartition" ] ; then
      partition=1 ;
#
# Further checks if DEVTYPE is disk; looking for weird setup where the
# entire USB key is formatted as one partition, without the standard
# partition table.
   elif [ "X${DEVTYPE}" == "Xdisk" ] ; then
#
# If it's "disk", check for string "FAT" in first 512 bytes of device.
# Flag as a partition if the string is found.
      if dd if=${MDEV} bs=512 count=1 2>/dev/null | grep "FAT" 1>/dev/null ; then
         partition=1
      fi
   fi
fi
#
# check for various conditions during a "remove" operation
if [ "X${ACTION}" == "Xremove" ] ; then
#
# Check for a disk or regular partition
   if [ "X${DEVTYPE}" == "Xpartition" ] || [ "X${DEVTYPE}" == "Xdisk" ] ; then
#
# Flag for unmounting if device exists in /proc/mounts mounted somewhere
# under the ${mountdir} directory (currently hardcoded as "/media").  It
# really should be unmounted manually by the user before removal, but
# people don't always remember.
      if grep "^/dev/${MDEV} ${mountdir}/" /proc/mounts 1>/dev/null ; then
         partition=1
      fi
   fi
#
# If the user has manually unmounted a device before disconnecting it, the
# directory is no longer listed in /proc/mounts.  This makes things more
# difficult.  The script has to walk through ${mountdir} and remove all
# directories that don't show up in /proc/mounts
   for dir in $( ls ${mountdir} )
   do
      if [ -d ${mountdir}/${dir} ]; then
         if ! grep " ${mountdir}/${dir} " /proc/mounts ; then
            rm -rf ${mountdir}/${dir}
         fi
      fi
   done
fi
#
####
if test -n `lsblk -o KNAME,FSTYPE|grep ${MDEV}|awk '{ print $2}'`  ;then
  partition=1;
fi
####
# If not flagged as a partition, bail out.
if [ ${partition} -ne 1 ] ; then exit 0 ; fi
#
# The "add" action.
if [ "X${ACTION}" == "Xadd" ] ; then
#
# Create the directory in ${mountdir}
   mkdir -p ${mountdir}/${MDEV}
#
# Mount the directory in ${mountdir}
##   pmount --umask 007 --noatime /dev/${MDEV}
######
   fstype=`lsblk -o KNAME,FSTYPE|grep ${MDEV}|awk '{ print $2}'`
   if [ ${fstype} == "vfat" ] ; then
     mount -t vfat -o rw,codepage=950,iocharset=utf8,fmask=0666 /dev/${MDEV} ${mountdir}/${MDEV} 
   elif [ ${fstype} == "ntfs" ] ; then
     mount -t ntfs-3g -o rw,noatime,codepage=950,iocharset=utf8,fmask=0666 /dev/${MDEV} ${mountdir}/${MDEV}
   elif [ ${fstype} == "exfat" ] ; then
     mount -t exfat -o rw,codepage=950,iocharset=utf8,fmask=0666 /dev/${MDEV} ${mountdir}/${MDEV}
   else
     mount -t auto -o sync /dev/${MDEV} ${mountdir}/${MDEV}
   fi
######
# The "remove" action.
elif [ "X${ACTION}" == "Xremove" ] ; then
#
# Get info from /proc/mounts, and call remove_action to unmount the
# device and remove the associated directory
   procmounts=$(grep "^/dev/${MDEV} ${mountdir}/" /proc/mounts)
   remove_action ${procmounts}
fi
```