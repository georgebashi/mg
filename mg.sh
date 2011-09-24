#!/bin/sh

if [ -z "${did_run_helper}" ]; then
  . .mg/mg/mghelper.sh
  exit
fi

mg_dir=$parent_dir/.mg/mg

git_config_cmd="git config -f $parent_dir/.mg/config"
mg_color_ok=`$git_config_cmd --get-color mg.color.ok green`
mg_color_fail=`$git_config_cmd --get-color mg.color.fail red`
mg_color_reset=`$git_config_cmd --get-color '' reset`

echo_ok() {
  echo " [${mg_color_ok}mg${mg_color_reset}] $@"
}
echo_fail() {
  echo " [${mg_color_fail}mg${mg_color_reset}] $@"
}
mg_exec() {
  child=$1
  shift 1
  echo_ok "$child: $@"
  (cd $child && eval $@)
}

children=`$git_config_cmd --get-regexp 'repo\..*' | cut -d '.' -f 2 | sort | uniq`

cmd="help"
if [ $# -gt 0 ]; then
  cmd=$1
  shift 1
fi

if [ ! -r "$mg_dir/mg-$cmd.sh" ]; then
  echo "$msg_prefix_fail Unknown command \"$cmd\""
  cmd="help"
fi

. $mg_dir/mg-$cmd.sh
exit

