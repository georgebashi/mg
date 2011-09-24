#!/bin/sh

if [ -z "${mg_helper_version}" ]; then
  . .mg/mg/mghelper.sh
  exit
fi

if [ $mg_helper_version -lt 2 ]; then
  echo_fail "the mg script on your \$PATH is out of date. Try $(fmt_cmd 'mg install')."
  exit 1
fi

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

(
  # always run command from within parent dir
  cd $parent_dir
  . $mg_dir/mg-$cmd.sh
)
exit

