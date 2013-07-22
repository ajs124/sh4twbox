#!/bin/bash
# vim:et sw=2 ts=2 ai
set -e -u

DIR="$HOME/web/sh4twbox"
IDX=sh4twbox.db.tar.xz
IDXOK=sh4twbox.db.ok
UPLOAD_CMD="$(dirname $(realpath $0))/to_googlecode.sh"

if [ $# -ne 1 ] ; then
  echo "Usage: `basename $0` <r/u> -- r:reindex, u:upload"
  exit 1
fi

case "$1" in
 r|u) ;;
 *) echo "Err: invalid option $1" ; exit 1 ;;
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


FILES=""
cd $DIR
for f in *-sh4.pkg.tar.xz *-any.pkg.tar.xz ; do
  if [ ! -r "$f" ] || [ -r "$f.ok" ] ; then continue ; fi
  echo "**processing $f"

  read name ver < <(basename $f .pkg.tar.xz|split_pkgname_pipe)
  for oldfile in $name-[0-9]*.pkg.tar.xz ; do
    if [ "$oldfile" = "$f" ] ; then continue ; fi
    echo "removing $oldfile(y/N)?"
    read x
    if [ "$x" = "y" ] ; then
      echo rm -f $oldfile $oldfile.ok
      rm -f $oldfile $oldfile.ok
    fi
    FILES="$FILES $f"
  done
done
if [ -n "$FILES" ] ; then
  echo repo-add $IDX $FILES
  repo-add $IDX $FILES

  echo rm $IDXOK
  rm $IDXOK
fi

if [ "$1" = "u" ] ; then
  echo "$UPLOAD_CMD"
  $UPLOAD_CMD
fi
