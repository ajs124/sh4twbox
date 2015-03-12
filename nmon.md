# nmon是一套Linux資源監控軟體(類似top) #
感謝 [Ryan Chiu](http://www.facebook.com/ryan.chiu.1694) 提供教學和測試

## 版本：sh4twbox shpkg版 & Arch Linux版 皆適用 ##

1.安裝nmon相關以及相關套件(安裝glibc、下載nmod、解壓縮至根目錄)
> $ `shpkg -S  glibc`

> $ `wget http://sh4twbox.googlecode.com/files/nmon_13g_sh4.tar`

> $ `tar xvf nmon_13g_sh4.tar -C /`

2.查看可用的參數，並且測試看看
  * 查看可用參數
> > $`nmon -h`

  * 啟動nmon ( (c)CPU , (m)Momery , (n)Network , (t)Process , (q)Quit )
> > $`nmon`

-Advanced-

收集資料產生報表(每10秒收集一次，收集60次，依時間標記產生報表到/home/的路徑下)

> $`nmon -s10 -c60 -f -m /home/`