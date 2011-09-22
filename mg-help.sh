#!/bin/sh

### Show (this) help

if [ $# -eq 0 ]; then
  # show summary
  for cmd in `find $mg_dir -name 'mg-*.sh'`; do
    cmdname=`basename $cmd .sh | cut -c 4-`
    help=`grep -i '###' $cmd | head -n 1 | cut -c 5-`
    echo "mg $cmdname: $help"
  done
fi
