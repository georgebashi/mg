#!/bin/sh

cwd=`pwd`
parent_dir=$cwd

while [ ! "/" = "$parent_dir" -a ! -r $parent_dir/.mg ]; do
  parent_dir=`dirname $parent_dir`
done

if [ "/" = $parent_dir ]; then
  echo " [mg] Can't find .mg dir!"
  exit 1
fi

did_run_helper=1
. $parent_dir/.mg/mg/mg.sh

