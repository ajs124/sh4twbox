#!/bin/bash
# vim:et sw=2 ts=2 ai
set -e -u

case "${1:-}" in
u|d) mode=$1 ;;
*) echo "Usage:$(basename $0) <u/d> -- u:update d:deploy" ; exit 1 ;;
esac

split_pkgname_pipe() {  # split x-x-1.3-1.x -> x-x 1.3-1.x
  # support forms: n-1 n-1-1 n-1-1-x86_64
  #[ $opt_v != 0 ] && echo "dbg:split_pkgname_pipe $*" >&2
  local line namever name ver rel
  while read line ; do
    namever="${line%-*}"
    rel="${line##*-}"
    if [ -z "$rel" ] ; then
      echo "Err:$LINENO pkgname missing '-' release number : $line" >&2
      exit 1
    fi
    if [[ $rel != [0-9]* ]] ; then # n-1-1-x86_64
      name="${namever%-*}"
      ver="${namever##*-}"
      namever="$name"
      rel="$ver-$rel"
    fi
    name="${namever%-*}"
    ver="${namever##*-}"
    if [[ $ver = [0-9]* ]] ; then # n-1-1, n-1-1-x86_64
      echo "$name $ver-$rel"
    else
      echo "$namever $rel"
    fi
  done
}

for f in *sh4.pkg.tar.xz ; do
  read name ver < <(basename $f .pkg.tar.xz|split_pkgname_pipe)
  echo "To t: $f $name"
  echo scp -i ~/.ssh/id_rsa -P80 "$f" t:web/sh4twbox
  scp -i ~/.ssh/id_rsa -P80 $f t:web/sh4twbox
  if [ $mode = u ] ; then
    echo dbclient -p80 -i ~/.ssh/id_rsa -t t web/sh4twbox/update_repo.sh
    dbclient -p80 -i ~/.ssh/id_rsa -t t web/sh4twbox/update_repo.sh "$f"
  else
    echo dbclient -p80 -i ~/.ssh/id_rsa -t t web/sh4twbox/deploy.sh "$f" $name
    dbclient -p80 -i ~/.ssh/id_rsa -t t web/sh4twbox/deploy.sh "$f" $name
  fi
  echo dbclient -p80 -i ~/.ssh/id_rsa -t t rm -f web/sh4twbox/$f.ok
  dbclient -p80 -i ~/.ssh/id_rsa -t t rm -f web/sh4twbox/$f.ok
done
