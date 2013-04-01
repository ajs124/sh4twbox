#!/bin/bash
cd $(dirname $(realpath $0))
f=sh4twbox.db.tar.xz
if [ -n "$1" ] ; then
  echo "repo-add $f $*"
  repo-add $f $*
else
  echo "repo-add $f $(ls *.pkg.tar.[gx]z 2>/dev/null)"
  repo-add $f $(ls *.pkg.tar.[gx]z 2>/dev/null)
fi
ls -l $f
