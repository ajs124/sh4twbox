#!/bin/bash
set -e -u 
go(){
  echo "** $@"
  "$@"
}

cd $(dirname $0)
for f in `ls *.pkg.tar.xz` sh4twbox.db ; do
  if [ ! -r  $f.ok ] ; then
    go googlecode_upload.py -s $f -p sh4twbox -l Type-Package,ArchLinux $f
    md5sum $f > $f.ok
  fi
done
