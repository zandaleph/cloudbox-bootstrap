#!/usr/bin/env bash

SCRIPT_PATH=`cd "\`dirname $0\`"; pwd`
BASE_PATH=`cd $SCRIPT_PATH/..; pwd`
RVM_PATH="$BASE_PATH/rvm"

$RVM_PATH/bin/ruby $BASE_PATH/scripts/start.rb
