#!/usr/bin/env bash

SCRIPT_PATH=`cd "\`dirname $0\`"; pwd`
VAR_PATH=`cd $SCRIPT_PATH/../var; pwd`

ssh -i $VAR_PATH/workspace_key.pem ec2-user@`cat $VAR_PATH/workspace_ip`
