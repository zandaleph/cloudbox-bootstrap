#!/usr/bin/env bash

SCRIPT_PATH=`cd "\`dirname $0\`"; pwd`
BASE_PATH=`cd $SCRIPT_PATH/..; pwd`
RVM_PATH="$BASE_PATH/rvm"

# Install RVM, ruby, and the aws-sdk gem
\curl -L https://get.rvm.io | HOME=$BASE_PATH bash -s -- stable --path $RVM_PATH --ignore-dotfiles --ruby --gems=aws-sdk
