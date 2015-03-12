# MySQL (資料庫程式) #
## 版本：sh4twbox Arch Linux版 ##
參考來源：[http://next.fishome.tw/bbs/read.php?tid=215&fid=37 ]
### 安裝 ###
```
 # pacman -S mysql
```
初始化資料庫、啟動服務及設定mysql的root帳號密碼
```
 # mysql_install_db --user=mysql
 # mysqld_safe --user=mysql & 
 # mysqladmin -u root password 'mypassword' 
```

### 測試 ###
以mysql的root帳號登入mysql指令介面：
```
 # mysql -u root -p 
```
顯示資料庫內容：
```
 mysql> show databases; 
```
顯示目前使用者：
```
 mysql> SELECT USER(); 
```
顯示目前版本：
```
 mysql> SELECT VERSION(); 
```
離開mysql指令介面：
```
 mysql> \q
```