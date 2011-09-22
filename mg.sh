#!/bin/sh

if [ -z "${did_run_helper}" ]; then
  . .mg/mg/mghelper.sh
  exit
fi

git_config_cmd="git config -f $mgdir/.mg/config"
mg_color_ok=`$git_config_cmd --get-color mg.color.ok green`
mg_color_fail=`$git_config_cmd --get-color mg.color.fail red`
mg_color_reset=`$git_config_cmd --get-color '' reset`
msg_prefix_ok=" [${mg_color_ok}mg${mg_color_reset}]"
msg_prefix_fail=" [${mg_color_fail}mg${mg_color_reset}]"

dirs=`$git_config_cmd --get-regexp 'repo\..*' | cut -d '.' -f 2 | sort | uniq`

for dir in $dirs; do
  if [ ! -e $dir ]; then
    echo "$msg_prefix_ok $dir: cloning"
    (cd $mgdir && git clone `$git_config_cmd --get repo.$dir.url` $dir)
  elif [ ! -d $dir ]; then
    echo "$msg_prefix_fail $dir: exists and is not a directory, skipping!"
  else
    echo "$msg_prefix_ok $dir: git fetch"
    (cd $mgdir && git fetch)
  fi
done
