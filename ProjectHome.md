本專案目標將[網樂通](http://zh.wikipedia.org/wiki/%E7%B6%B2%E6%A8%82%E9%80%9A)機上盒改成Linux, 支援 Arch/Debian/Fedora等系統, 運用 [Arch Linux](https://www.archlinux.org/) 的 [AUR](https://aur.archlinux.org/)
套件庫提供豐富的 Linux 套件([PKGBUILD](https://wiki.archlinux.org/index.php/PKGBUILD) 格式編譯腳本)
  * [sh4twbox 安裝及使用手冊](https://docs.google.com/document/d/1UWJxV8N8fbvjcvePgrruRmZuJwPseCyHZvebNddeYWc/pub) 發問前請讀使用手冊
  * [shpkg 套件管理說明](http://www.twpda.com/2013/01/stlinux-615-shpkg.html)
  * 開發網站 [www.twpda.com](http://www.twpda.com)

壹電視停止營運後網樂通變成沒用的垃圾, 其實它可以改成省電的 Linux 主機, 也就是本站的 sh4twbox. 這名字是下列三個原因組成
  * 網樂通內部的核心(CPU)架構稱為 sh4
  * 網樂通是壹電視停止網路電視營運後給台灣的免費禮物(Taiwan 網域 .tw)
  * 網樂通外型就是個盒子(box)

sh4twbox 主要有下列特色

  * 記憶體多: 自編的 kernel 支援 256M 記憶體 (原始網樂通僅 128M), 編譯方式如連結
  * 可用套件多:
    * Arch Linux: 以pacman套件管理,可編譯官方套件10849套、社群套件41708套
    * 最小安裝: 以較陽春的 shpkg 套件管理, 支援自編套件及引入第三方編輯套件，已有現成套件9000套以上
  * 開機對時: 網樂通連上網路後, 自動設為台北時區
  * 架構精簡: 僅安裝必要套件, 開機程序精簡易於理解學習, 可將自定啟動程序放在 /etc/rc.local
    * Arch Linux: /etc/inittab, /etc/rc.sysinit, /etc/conf.d/, /etc/rc.d/
    * 最小安裝: /etc/inittab, /etc/init.d/rcS
  * 具有 system log, 易於除錯
  * 已內建 加強版busybox bash ntpdate ssh ssh-keygen sshd scp tune2fs fdisk fossil 若要移除先用 shpkg 安裝再移除即可.
  * 可啟動 sshd(使用較省資源的 dropbear-scp套件) 只要使用 scp 或是 winscp 即可在遠端 copy/edit 網樂通內部檔案
  * 支援安裝其他 linux 系統預先設定的檔案系統, 如 [fedora, debian](https://code.google.com/p/sh4twbox/downloads/list?q=Type%3DRootfs) 等

sh4twbox 陸續開發需要大家贊助作者群, 每人100元起, 就有機會讓 sh4twbox 持續更新，願意贊助者請先查看 www.twpda.com 右上角贊助資訊, 或聯絡 E-Mail: nextvod @ twpda.com

相關程式碼:

  * ubootwpda: https://github.com/dlintw/twpda-uboot
  * kernel-pdk7105: https://github.com/dlintw/kernel-pdk710a5/tree/twpda
  * Arch SH4 PKGBUILDs: https://code.google.com/p/sh4twbox/source/checkout