#!/usr/bin/env bash

SCRIPT_PATH=`cd "\`dirname $0\`"; pwd`
VAR_PATH=`cd $SCRIPT_PATH/../var; pwd`
IP_ADDR=`grep :ip: $VAR_PATH/workspace_info | sed 's/:ip: //'`

ssh -i $VAR_PATH/workspace_key.pem ec2-user@$IP_ADDR
