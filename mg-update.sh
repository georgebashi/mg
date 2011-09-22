
### Update child repositories

for dir in $dirs; do
  if [ ! -e $dir ]; then
    url=`$git_config_cmd --get repo.$dir.url`
    echo "$msg_prefix_ok $dir: git clone $url $dir"
    (cd $parent_dir && git clone $url $dir)
  elif [ ! -d $dir ]; then
    echo "$msg_prefix_fail $dir: exists and is not a directory, skipping!"
  else
    if [ ! -d $dir/.git ]; then
      echo "$msg_prefix_fail $dir: exists and isn't a git repository, skipping!"
    else
      echo "$msg_prefix_ok $dir: git fetch"
      (cd $parent_dir && git fetch)
    fi
  fi
done
