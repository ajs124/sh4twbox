# Iptraf為Linux文字介面下一個好用的流量監控軟體 #

## 版本：sh4twbox Arch Linux版 ##
```
 # pacman -Syu
 # pacman -S iptraf
```

## 版本：sh4twbox shpkg版 ##
本文轉錄自 http://tinyurl.com/aoee6fc

1.安裝Iptraf相關套件
```
  $ shpkg -S iptraf ncurses-base ncurses-libs xterm
```

2.檢查相依性，如需安裝，請按Enter讓他相關套件。
```
  $ shpkg -E
```

3.設定Terminal環境
```
  $ declare -x TERM="xterm"
  $ declare -x TERMINFO="/usr/share/terminfo"
```
4.啟動iptraf
```
  $ iptraf
```

5.確定可執行ipTraf後，可將第三點的內容寫進/etc/profile ，以便登入時執行iptraf時找得到Terminal設定
```
  $ echo "declare -x TERM="xterm" " >> /etc/profile
  $ echo "declare -x TERMINFO="/usr/share/terminfo" " >> /etc/profile
```