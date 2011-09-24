#!/bin/sh

mg_home="$( cd "$( dirname "$0" )" && pwd )"

# set up colours
mg_color_ok=`git config --get-color '' green`
mg_color_fail=`git config --get-color '' red`
mg_color_cmd=`git config --get-color '' white bold`
mg_color_reset=`git config --get-color '' reset`

# basic essential functions
echo_ok() {
  echo " [${mg_color_ok}mg${mg_color_reset}] $@"
}
echo_fail() {
  echo " [${mg_color_fail}mg${mg_color_reset}] $@"
}
fmt_cmd() {
  echo "${mg_color_cmd}$@${mg_color_reset}"
}
mg_exec() {
  child=$1
  shift 1
  echo_ok "$child: $(fmt_cmd $@)"
  (cd $child && eval $@)
}
mg_exec_parent() {
  echo_ok "$(fmt_cmd $@)"
  (eval $@)
}

# capture env
cwd=`pwd`

# find parent dir
parent_dir=$cwd
while [ ! -z "${parent_dir}" -a ! -r $parent_dir/.mg ]; do
  parent_dir=${parent_dir%/*}
done

need_mg_dir() {
  if [ -z $parent_dir ]; then
    echo_fail "Can't find .mg dir!"
    exit 1
  fi
  mg_dir=$parent_dir/.mg
}

# if we're inside an mg-managed project
if [ ! -z $parent_dir ]; then

  # if there's a frozen mg present, adjust mg_home to match
  if [ -d $parent_dir/.mg/mg ]; then
    mg_home=$parent_dir/.mg/mg
  fi

  # read config
  git_config_cmd="git config -f $parent_dir/.mg/config"
  children=`$git_config_cmd --get-regexp 'repo\..*\.url' | sed 's/repo\.\(.*\)\.url.*/\1/g'`
fi

# if $0 isn't mg, then we've been included from a subcommand
# as the user has directly run a subcommand script
if [ "${0##*/}" = "mg" ]; then
  # select subcommand to run
  cmd="help"
  if [ $# -gt 0 ]; then
    cmd=$1
    shift 1
  fi

  # find subcommand
  if [ ! -r "$mg_home/mg-$cmd" ]; then
    echo "$msg_prefix_fail Unknown command \"$cmd\""
    cmd="help"
  fi

  (
  # always run command from within parent dir if available
  if [ ! -z $parent_dir ]; then
    cd $parent_dir
  fi
  . $mg_home/mg-$cmd
  )
  exit
fi
