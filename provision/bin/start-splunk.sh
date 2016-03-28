#!/usr/bin/env bash

status=`sudo ${SPLUNK_BIN} status`

echo "Splunk status is: $status"

# maybe status command can emit status codes instead...
if [ "$status" == "splunkd is not running." ]; then
    sudo ${SPLUNK_BIN} start --accept-license
    IP=$(ifconfig eth1 | sed -ne 's/.*inet addr:\([0-9.]\+\) .*/\1/p')
cowsay <<MOO
        Splunk is available: "${IP}:8000"
MOO
fi