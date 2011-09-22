
### Run a command for each child repository

for dir in $dirs; do
  if [ ! -e $dir ]; then
    echo "$msg_prefix_fail $dir: does not exist, run mg update"
  elif [ ! -d $dir ]; then
    echo "$msg_prefix_fail $dir: exists and is not a directory, skipping!"
  else
    if [ ! -d $dir/.git ]; then
      echo "$msg_prefix_fail $dir: exists and is not a git repository, skipping!"
    else
      echo "$msg_prefix_ok $dir: $@"
      (cd $dir && eval $@)
    fi
  fi
done
