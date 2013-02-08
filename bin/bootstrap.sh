#!/usr/bin/env bash

SCRIPT_PATH=`cd "\`dirname $0\`"; pwd`
BASE_PATH=`cd $SCRIPT_PATH/..; pwd`
RVM_PATH="$BASE_PATH/rvm"

# Install RVM (not sure if this is local to the directory yet)
# this may involve setting $HOME temporarily
\curl -L https://get.rvm.io | HOME=$BASE_PATH rvm_ignore_rvmrc=1 bash -s -- stable --path $RVM_PATH --ignore-dotfiles --ruby
