#!/bin/sh

cwd=`pwd`
parent_dir=$cwd

while [ ! -r $parent_dir/.mg ]; do
  parent_dir=${parent_dir%/*}

  if [ -z $parent_dir ]; then
    echo " [mg] Can't find .mg dir!"
    exit 1
  fi
done


did_run_helper=1
. $parent_dir/.mg/mg/mg.sh

