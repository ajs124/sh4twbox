聲明: 建議改用 Arch Linux 方式管理套件(pacman/yaourt) 以避免 shpkg 發生的相依性問題.

但若你需要的就是超精簡安裝, shpkg 就是你的好幫手.
因為 fedora repository 已經倒站, 若需要其中的部份套件, 請發 issue說明需要哪些套件, 本站會擇期上傳到 Download 區供下載.

# 使用 shpkg 安裝套件 #
shpkg 內建有 shpkg -E 選項, 可以用來找出第一層 .so 缺檔所需安裝之套件.

例如: 出現類似訊息
iptraf: error while loading shared libraries: libpanelw.so.5: cannot open shared object file: No such file or directory

只要輸入 shpkg -E 就可找出還需要裝 ncurses-libs
有些程式可能要多跑幾次 shpkg -E 就可以找到完整相依性.

已測過套件:  agrep, [dropbear-scp](http://wiki.openwrt.org/oldwiki/DropbearPublicKeyAuthenticationHowto),
nano,
[openvpn](http://next.fishome.tw/forum.php?mod=viewthread&tid=161),
patch, squid, strace, sudo, transmission-cli, xz, [ushare](http://oranqe.wordpress.com/2013/03/01/back-nextvod-to-its-original-purpose)

無法透過 shpkg -E 找到的套件相依性, 將列於此頁, 若還需額外安裝程序則另外分段落說明.

  * emacs: emacs-common emacs-common-ebib emacs-common-ess emacs-common-muse emacs-common-tuareg
  * iptraf, less: stlinux23-sh4-ncurses-base
  * man: stlinux23-sh4-man-db stlinux23-sh4-groff stlinux23-sh4-man-pages (可不裝)  (另外 ln -s tbl /usr/bin/gtbl 修正套件問題)
  * sudo: 裝完後手動 chmod u+s /usr/bin/sudo
  * vim: vim-enhanced stlinux23-sh4-diff (注意:不要裝 vim-minimal, 以免刪去 busybox 內建功能)
  * [vsftpd](http://paste.ubuntu.com/1669847): [/etc/init.d/vsftpd](http://paste.ubuntu.com/1669825/)

## dropbear scp/ssh 免密碼設定 ##
若要使用較高安全性, 不打密碼的方式參考 [1](http://maemo.org/community/oldwiki/installssh/),[2](http://lists.ucc.gu.uwa.edu.au/pipermail/dropbear/2005q1/000166.html)
做完設定後先測試可否不打密碼進入

```
client : 
  dropbearkey -t rsa -f ~/.ssh/id_rsa
  dropbearkey -f ~/.ssh/id_rsa -y >> ~/.ssh/id_rsa.pub
  echo "alias scp='scp -i ~/.ssh/id_rsa '" >> ~/.bashrc
  echo "alias ssh='dbclient -i ~/.ssh/id_rsa '" >> ~/.bashrc
server :
  # copy id_rsa.pub from client
  cat id_rsa.pub >>~/.ssh/authorized_keys
```
修改 /etc/sysconfig/dropbear 將 -s 選項加入關掉輸入密碼功能