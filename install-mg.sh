#!/bin/bash

# Adapted by George Bashi for mg from:
# git-flow make-less installer for *nix systems, by Rick Osborne
# Based on the git-flow core Makefile:
# http://github.com/nvie/gitflow/blob/master/Makefile

# Licensed under the same restrictions as the git-flow make-less
# installer, which is licensed under the same restrictions as
# git-flow:
# http://github.com/nvie/gitflow/blob/develop/LICENSE

# Does this need to be smarter for each host OS?
if [ -z "$INSTALL_PREFIX" ] ; then
  INSTALL_PREFIX="/usr/local/bin"
fi

if [ -z "$REPO_NAME" ] ; then
  REPO_NAME="mg"
fi

if [ -z "$REPO_HOME" ] ; then
  REPO_HOME="https://github.com/georgebashi/mg.git"
fi

EXEC_FILES="mg mg-foreach mg-freeze mg-help mg-update mg-init"
SCRIPT_FILES=""

echo "### mg installer ###"

case "$1" in
  uninstall)
    echo "Uninstalling mg from $INSTALL_PREFIX"
    if [ -d "$INSTALL_PREFIX" ] ; then
      for script_file in $SCRIPT_FILES $EXEC_FILES ; do
        echo "rm -vf $INSTALL_PREFIX/$script_file"
        rm -vf "$INSTALL_PREFIX/$script_file"
      done
    else
      echo "The '$INSTALL_PREFIX' directory was not found."
      echo "Do you need to set INSTALL_PREFIX ?"
    fi
    exit
    ;;
  help)
    echo "Usage: [environment] install-mg.sh [install|uninstall]"
    echo "Environment:"
    echo "   INSTALL_PREFIX=$INSTALL_PREFIX"
    echo "   REPO_HOME=$REPO_HOME"
    echo "   REPO_NAME=$REPO_NAME"
    exit
    ;;
  *)
    echo "Installing mg to $INSTALL_PREFIX"
    if [ -d "$REPO_NAME" -a -d "$REPO_NAME/.git" ] ; then
      echo "Using existing repo: $REPO_NAME"
      (cd $REPO_NAME && git pull)
    else
      echo "Cloning repo from GitHub to $REPO_NAME"
      git clone "$REPO_HOME" "$REPO_NAME"
    fi
    install -v -d -m 0755 "$INSTALL_PREFIX"
    for exec_file in $EXEC_FILES ; do
      install -v -m 0755 "$REPO_NAME/$exec_file" "$INSTALL_PREFIX"
    done
    for script_file in $SCRIPT_FILES ; do
      install -v -m 0644 "$REPO_NAME/$script_file" "$INSTALL_PREFIX"
    done
    exit
    ;;
esac
