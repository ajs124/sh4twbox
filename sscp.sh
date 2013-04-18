#!/bin/bash
# vim:et sw=2 ts=2 ai
set -e -u

case "${1:-}" in
u|a|d) mode=$1 ;;
*) echo "Usage:$(basename $0) <a/u/d> -- a:any u:update d:deploy" ; exit 1 ;;
esac

SSH="ssh -p80"
SCP="scp -P80"
if [ -x /usr/bin/dbclient ] ; then
  SSH="dbclient -p80 -i ~/.ssh/id_rsa -t"
  SCP="scp -i ~/.ssh/id_rsa -P80"
fi

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

FILES="*sh4.pkg.tar.xz"
if [ "$mode" = "a" ] ; then
  mode=u
  FILES="*any.pkg.tar.xz"
fi
for f in $FILES ; do
  if [ $f = initscripts-2011.12.1-1-any.pkg.tar.xz ] ; then
    continue
  fi
  read name ver < <(basename $f .pkg.tar.xz|split_pkgname_pipe)
  echo "To t: $f $name"
  echo $SCP "$f" t:web/sh4twbox
  $SCP $f t:web/sh4twbox
  if [ $mode = u ] ; then
    echo $SSH t web/sh4twbox/update_repo.sh
    $SSH t web/sh4twbox/update_repo.sh "$f"
  else
    echo $SSH t web/sh4twbox/deploy.sh "$f" $name
    $SSH t web/sh4twbox/deploy.sh "$f" $name
  fi
  echo $SSH t rm -f web/sh4twbox/$f.ok
  $SSH t rm -f web/sh4twbox/$f.ok
done
