# uShare 是一個uPnp/DLNA server #
  * 注意：當有增減檔案時，要先中止執行中的ushare
```
 # killall -9 ushare
```
> 再次啟動時會重新掃描檔案的變更。
## 版本：sh4twbox shpkg版 ##

1.安裝uShare
```
  $ shpkg -S ushare
```

2.檢查套件相依性，如果有，請按Enter讓系統自行安裝所需套件。
```
 $ shpkg -E
```

3.uShare的設定檔在/etc/ushare.conf，相關設定可參照 [這裡](https://wiki.archlinux.org/index.php/UShare)
```
 $ vi /etc/ushare.conf
```

主要有以下三個。
  * SHARE\_NAME= [server的名字]
  * SHARE\_DIR= [分享的資料夾，可多個，用逗號隔開]
  * SHARE\_OVERRIDE\_ICONV\_ERR= [如有中文檔名，請設成YES]

4.先試著啟用uShare看看。
```
 $ /etc/init.d/ushare start
```

5.在/etc/rc.local加入/etc/init.d/ushare start，讓開機自動啟動。
用sleep等待15秒，等取得ip後才啟動，沒取得ip uShare會啟動失敗。
```
 $ echo "sleep 15 #wait for DHCP" >> /etc/rc.local
 $ echo "/etc/init.d/ushare start" >> /etc/rc.local
```

6.重開機後，可用ps去檢查是否有成功啟用。
```
 $ ps |grep ushare
```
> ->xxx  root       0:01 /usr/bin/ushare -f /etc/ushare.conf

## 版本：sh4twbox Arch Linux版 ##
### 安裝 ###
```
 # pacman -Syu
 # pacman -S ushare
```
### 設定 ###
編輯設定檔
```
 # vi /etc/ushare/ushare.conf
```
> 參考shpkg的 ushare.conf 設定
### 啟動 ###
```
 # ushare -D
```
> 如果在 ushare.conf 有設定 USHARE\_ENABLE\_WEB=yes，
> 啟動時指定port避免衝突，
> 設定網頁：http://ip_address:54321/web/ushare.html
```
 # ushare -p 54321 -D
```
開機啟動
```
 # echo "ushare -D" >> /etc/rc.local
```
## 遙控器設定 ##
安裝 lircd後，
將下面程式碼加到 /etc/lircrc ，
可以用遙控器上的 Search 按鈕(KEY\_SEARCH)重新啟動 ushare ，
就會更新檔案列表。
```
begin
  button = KEY_SEARCH
  prog   = irexec    
  repeat = 0          
  config = killall -9 ushare;ushare -D -p 54321
  flags  = quit                                
end
```

## 支援格式 ##

|Video | asf, avi, dv, divx, wmv, mjpg, mjpeg, mpeg, mpg, mpe, mp2p, vob, mp2t, m1v, m2v, m4v, m4p, mp4ps, ts, ogm, mkv, rmvb, mov, qt|
|:-----|:-----------------------------------------------------------------------------------------------------------------------------|
|Audio | aac, ac3, aif, aiff, at3p, au, snd, dts,  rmi,  mp1,  mp2,  mp3, mp4, mpa, ogg, wav, pcm, lpcm, l16, wma, mka, ra, rm, ram |
|Images| bmp,  ico,  gif,  jpeg,  jpg, jpe, pcd, png, pnm, ppm, qti, qtf, qtif, tif, tiff|
|Playlist | pls, m3u, asx|
|Subtitles | dks, idx, mpl, pjs, psb, scr, srt, ssa, stl, sub, tts, vsf, zeg|
|Miscellaneous files | bup, ifo|