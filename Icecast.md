# Icecast2是一套網路廣播系統 #
> •	此教學為Archlinux版本
> •	可以將Icecsat2想成一台主機，將客戶端提供的串流廣播出去。所以不只要安裝
> > Icecast2，還要裝ices把音樂交給Icecast2廣播出去


## 版本：Archlinux pacman版 ##



1.首先安裝icecast2，sh4twbox已經有編譯好的套件，可直接下載安裝

> •	$pacman -S icecast-svn

2.安裝ices
> •	選擇安裝ices0  or  ices2 : ices2支援.ogg格式(不支援.mp3)，ices0支
> > 援.mp3，ices2在sh4twbox已經有編譯好的套件 ，ices0需要自己編


> o	Ices2: $pacman  -S ices2

> o	Ices0: 參考林大編譯ices2的記錄  http://ascii.io/a/3014   自己編譯
> > ices0，編譯完用pacman  -U 安裝，下面的設定是以ices0為例

3.設定icecast.xml  檔案放在 /etc/icecast/icecast.xml

> •	vim /etc/icecast/icecast.xml 調整參數 可參考我的範例檔
> > http://m100.nthu.edu.tw/~s100061587/icecast.xml username改成你
> > 的username  hackme改成你的密碼，相關設定可參考
> > http://www.icecast.org/docs/icecast-2.0.1/icecast2_config_file.html 自行設定

4.設定ices.conf

> •	vim /usr/share/ices0/ices.conf.dist調整參數 可參考我的範例檔
> > http://m100.nthu.edu.tw/~s100061587/ices.conf.dist
> > hackme改成你的密碼(需要和icecast.xml的密碼一樣) ices0才能連上icecast2

5.創建歌單  vim /playlist.txt

> •	檔案記錄你的音樂檔位置  例如  /home/stephen771015/music/梁靜茹-崇拜/01
> > 崇拜.mp3  一首歌一行(資料夾可以是中文但不能有空白或著奇怪的符號)

> •	可以用下列指令自動建立歌單    find  /home/stephen771015/music/ -name        "星號.mp3" > /playlist.txt  (位置自行改你音樂檔的資料夾)

6.啟動程式  需要先啟動icecast2  再啟動ices0
> •	icecast -b -c  /etc/icecast/icecast.xml   (可以打
> > http://192.168.0.?:8000/  若成功啟動會有畫面)

> •	ices0 -c /usr/share/ices0/ices.conf.dist

7.log檔位置
> •    icecast的log檔 /var/icecast/log/error.log
> •    ices0的log檔  /var/log/ices/ices.log


> stpehen771015@hotmail.com