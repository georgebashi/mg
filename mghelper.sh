#!/bin/sh

cwd=`pwd`
mgdir=$cwd

# find mg file

while [ ! "/" = "$mgdir" -a ! -r $mgdir/.mg ]; do
  mgdir=`dirname $mgdir`
done

if [ "/" = $mgdir ]; then
  echo "fatal: Not a mg repository (or any of the parent directories): .mg"
  exit 1
fi

did_run_helper=1
. $mgdir/.mg/mg/mg.sh

