#!/usr/bin/env bash

# Provision script that performs setup of Splunk and loads data.

# Install the necessities
sudo apt-get -y install cowsay > /dev/null 2>&1 
sudo dpkg -i /vagrant/provision/lib/${SPLUNK_DEB}

# Start Splunk
sudo ${SPLUNK_BIN} start --accept-license

# Load data into Splunk
if [ -d "${DATA_DIR}" ]; then
    # Setup Splunk index, and load sample data
    ${SPLUNK_BIN} add index ${SPLUNK_INDEX} -auth ${SPLUNK_AUTH}
  
    # Any .log files in the directory will be loaded
    for f in ${PROV_DIR}/data/*.log
    do
        ${SPLUNK_BIN} add oneshot "$f" -index ${SPLUNK_INDEX} -auth ${SPLUNK_AUTH}
    done
fi

IP=$(ifconfig eth1 | sed -ne 's/.*inet addr:\([0-9.]\+\) .*/\1/p')

cowsay <<MOO

Splunk is available: "${IP}:8000"

MOO