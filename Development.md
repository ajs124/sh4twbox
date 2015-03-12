# 開發相關文件 #

  * git: [中文教學](http://www.slideshare.net/icyleaf/git-14214592), [設定google code wiki](http://alblue.bandlem.com/2011/07/setting-up-google-code-with-git.html)

## STLinux ##
  * [install uboot from remote](http://www.stlinux.com/u-boot/target-install)
  * [Install cross compile environment by dockerfile](https://gist.github.com/dlintw/8859508)

## Arch Linux ##
  * Arch Linux 使用者套件庫: https://aur.archlinux.org/
  * [Creating\_Arch\_Linux\_disk\_image](https://wiki.archlinux.org/index.php/Creating_Arch_Linux_disk_image)
  * [Building in a Clean Chroot](https://wiki.archlinux.org/index.php/DeveloperWiki:Building_in_a_Clean_Chroot)

## fedora ##
  * [source rpm of fedora 14(without systemd)](http://fedora-mirror01.rbc.ru/pub/rpmfusion/free/fedora/releases/14/Everything/source/SRPMS/)
### Build RPM from SRPM ###
```
# get source rpm, eg. nano*.src.rpm
# patch fc9 directory problem
mkdir -p /usr/src/redhat/SOURCES /usr/src/redhat/BUILD /usr/src/redhat/RPMS/sh4

yum install -y ntpdate

rpmbuild --rebuild nano*.src.rpm

# let yum workable
vi /etc/yum.repos.d/fc9.repo  # setup repo resource
yum clean all # clean cache 
yum install -y ncurses-devel autoconf gettext-devel 
```

## debian wheezy-sh4 ##
