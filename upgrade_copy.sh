#!/bin/bash
# vim:et sw=2 ts=2 ai
set -e -u

if [ $# -ne 1 ] ; then
  echo "Usage:$(basename $0) <host> -- upgrade & copy to host"
  exit 1
fi

REPOHOST="$1"
#CMD="ssh -p80"
#SCP="scp -P80"
CMD="ssh "
CP="scp"
DSTHOST="$REPOHOST:"
if [ -x /usr/bin/dbclient ] ; then
  CMD="dbclient -i ~/.ssh/id_rsa -$REPOHOST "
  CP="scp -i ~/.ssh/id_rsa"
fi
if [ `hostname` = $REPOHOST ] ; then
  CP="cp"
  DSTHOST="$HOME/"
  CMD=""
else
  CMD="$CMD $REPOHOST"
fi

for f in *-sh4.pkg.tar.xz *-any.pkg.tar.xz ; do
  if [ ! -r "$f" ] || \
    [ "$f" = initscripts-2011.12.1-1-any.pkg.tar.xz ] ; then
    continue
  fi
  echo yaourt -U --needed $f
  yaourt -U --needed $f

  echo $CP "$f" ${DSTHOST}web/sh4twbox
  $CP $f ${DSTHOST}web/sh4twbox

  echo $CMD rm -f $HOME/web/sh4twbox/$f.ok
  $CMD rm -f $HOME/web/sh4twbox/$f.ok
done
