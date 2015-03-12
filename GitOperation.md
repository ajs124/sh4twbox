#原始程式使用 git 版本控管軟體, 修改指令說明

# 安裝 #
## server side ##
  * github.com (公開免費、私有付費)
  * bitbucket.com (5使用者免費、更多付費)

## client side ##
  * Arch Linux: yaourt -S git gitflow-git
  * Ubuntu/Debian: apt-get install -y git git-flow
  * Fedora: yum install -y git gitflow

# 初次設定 #
```
git config --global user.name "Your Name"
git config --global user.email "Your email"
```

# 概念 #

## 分段式存檔備份 ##
source code 修改區分為三區:
  1. working: ->staging(git add/rm/mv)
  1. staging: ->final(git commit) ->working(git rm)
  1. final: ->staging(git comment --amend) ->remote:(git push)
  1. remote:

## 分支 ##
http://nvie.com/posts/a-successful-git-branching-model

先建立 issue, 得到編號 XXX, 分支名稱命名為 XXX-the-meaning-of-issue
```
git branch XXX-the-meaning-of-issue
# 修改程式
git commit -a -m 'Fixes #XXX, some desciption'
```

# 解決衝突 #

# 特殊處理 #

  * 修改已經 local commit 檔案/註解: git rebase -i