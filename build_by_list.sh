#!/bin/bash
# vim:et sw=2 ts=2 ai:
set -e -u
if [ $# -ne 1 ] ; then
  echo "Usage:$(basename $0) <pkgname>"
  exit 1
fi
f=~/$1.makelist
go() {
  echo "  *** $@"
  "$@"
}

if [ ! -r $f ] ; then
  rc=0
  echo "Generating $f ..."
  #pacman -Qq $1 >/dev/null 2>&1 || rc=1
  #if [ $rc = 1 ] ; then
  #  echo "Err: list should generated on $1 installed Arch Linux"
  #  exit 1
  #fi
  opt_conf=""
  [ `uname -m` = sh4 ] && opt_conf="--conf /etc/pacman.src.conf"
  pactree $opt_conf -slu $1 | grep -v -e '^lib32' -e multilib \
    | awk '{print $1}' | tac > $f
  echo "Generated Done"
fi
echo "install $1 from $f"
for name in $(cat $f) ; do
  if [ -z "${name##\#*}" ] ; then
    echo "*** skip $name"
    continue
  fi
  rc=0
  echo "*** checking $name installed?"
  pacman -Qq $name >/dev/null 2>&1 || rc=1
  if [ $rc = 1 ] ; then
    echo "*** checking $name exist on sh4twbox repository?"
    rc=0
    go yaourt -Syp $name >/dev/null 2>&1 || rc=1
    if [ $rc = 0 ] ; then
      echo "yaourt -S $name"
      echo "yaourt -S -f --noconfirm $name # if  failed"
      rc=0
      go yaourt -S $name || rc=1
      if [ $rc = 0 ] ; then
        continue
      else
        echo "Err: install [$name] failed!"
        break
      fi
    fi
    echo "*** checking $name is any-arch in arch repository?"
    file=`pacman -Sp --config /etc/pacman.src.conf $name 2>/dev/null | head -1 | awk '{print $1}'`
    if [ -n "$file" ] ; then
      sname="$(basename $file)"
      if [[ "$sname" = *"any.pkg.tar.xz" ]]; then
        echo "*** geting any arch pkg file $name"
        mkdir -p ~/abs/local/$name
        cd ~/abs/local/$name
        go wget $file -O $sname.part
        mv $sname.part $sname
        go scp -i ~/.ssh/id_rsa -P80 $sname t:web/sh4twbox
        go dbclient -p80 -i ~/.ssh/id_rsa -t t web/sh4twbox/update_repo.sh "$sname"
        go yaourt -Syf --noconfirm $name
        continue
      fi
    fi
    cd / # prevent yaourt check directory name
    echo "*** building $name"
    cd ~/abs/local
    go yaourt --config /etc/pacman.src.conf -G $name
    cd $name
    echo "makepkg -Asd --nocheck --skippgpcheck --skipinteg # if failed"
    go makepkg -As --nocheck --skippgpcheck --skipinteg -L
    ../sscp.sh u
    go yaourt -Syf --noconfirm $name
  fi
done
