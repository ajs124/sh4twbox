#紅外線模組

# 使用遙控器模組方式 #

  * https://groups.google.com/forum/#!topic/asterisk-tw/G-Ibtp8IS10
  * http://blog.chinaunix.net/uid-22780578-id-2559868.html

## 版本：sh4twbox Arch Linux 版 ##
```
pacman -S lirc-apps
 # ln -s /dev/lirc0 /dev/lirc
```
啟動
```
 # /etc/init.d/lircd start
```
測試按鍵反應（按 Ctrl+c 結束）
```
 $ irw
```

# 按鍵事件設定檔 #
沒有 ~/.lircrc 則使用共用設定檔 /etc/lircrc

## 設定檔範例 ##
編輯：
```
 # vi [設定檔]
```
當有 irexec 執行時，
按下 power 按鈕會把參數 sync 傳給 irexec，
按鈕持續按住時重複0次，
mode = power 表示會進入 begin power 到 end power 之間。
完整程序為 按下 power 按鈕後，
先 sync ，
之後如果再按紅色按鈕則關機，
如果按藍色按鈕則重開機。
```
begin
  button = KEY_POWER
  prog   = irexec
  repeat = 0
  config = sync
  mode   = power
  flags  = quit
end

begin power
  begin
    button = KEY_RED
    prog   = irexec
    repeat = 0
    config = sync;halt
    flags  = quit
  end
  begin
    button = key_BLUE
    prog   = irexec
    repeat = 0
    config = sync;reboot
    flags  = quit
  end
end power
```
[lircrc 格式說明](http://www.lirc.org/html/configure.html#lircrc_format)

# 開機啟用 #
```
 # echo "ln -s /dev/lirc0 /dev/lirc" >> /etc/rc.local
 # echo "/etc/init.d/lircd start" >> /etc/rc.local
```
開機就有irexec可以接收要傳給irexec的參數
```
# echo "irexec &" >> /etc/rc.local
```