#!/bin/sh

# this flag ensures compatibility between the helper and subcommands
mg_helper_version=1

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

# capture env
cwd=`pwd`

# find parent dir
parent_dir=$cwd
while [ ! -r $parent_dir/.mg ]; do
  parent_dir=${parent_dir%/*}

  if [ -z $parent_dir ]; then
    echo_fail "Can't find .mg dir!"
    exit 1
  fi
done

mg_dir=$parent_dir/.mg/mg

git_config_cmd="git config -f $parent_dir/.mg/config"

. $parent_dir/.mg/mg/mg.sh

