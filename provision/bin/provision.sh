#!/usr/bin/env bash

# Provision script that performs setup of Splunk and loads data.

# Install the necessities
sudo apt-get update
sudo apt-get -y install cowsay > /dev/null 2>&1 
sudo dpkg -i /vagrant/provision/lib/${SPLUNK_DEB}

# accessing the splunk version from the passed in deb file
SPLUNK_VER=$(echo $SPLUNK_DEB | grep -oP '[0-9]\.[0-9]\.[0-9]' | cut -d '.' -f 1)

# if the splunk version is 7 or greater
# if [[ $SPLUNK_VER -ge 7 ]] ; then
#
#         # testing if the subversion of splunk is 7.1 or greater
#         if [[ $( echo $SPLUNK_VER | cut -d '.' -f 2 ) -ge 1 ]] ; then
#
#                 # testing if the file does not exists for the username and password
#                 if [[ ! -z  ${SPLUNK_HOME}/etc/system/local/user-seed.conf ]] ; then
#
#                         # setting password for splunk
#                         sudo -u root bash -c "cat >> ${SPLUNK_HOME}/etc/system/local/user-seed.conf << EOF
# [user_info]
# USERNAME = admin
# PASSWORD = ${SPLUNK_PASS}
# EOF"
#                 fi
#         fi
# fi

# Start Splunk
sudo ${SPLUNK_BIN} start --accept-license

# Load data into Splunk
if [ -d "${DATA_DIR}" ]; then
    # Setup Splunk index, and load sample data
    sudo ${SPLUNK_BIN} add index ${SPLUNK_INDEX} #-auth ${SPLUNK_AUTH}
  
    # Any .log files in the directory will be loaded
    for f in ${DATA_DIR}/*.log; do
        if [ -e "$f" ]; then
            sudo ${SPLUNK_BIN} add oneshot "$f" -index ${SPLUNK_INDEX} #-auth ${SPLUNK_AUTH}
        fi
    done
fi

IP=$(ifconfig enp0s8 | sed -ne 's/.*inet addr:\([0-9.]\+\) .*/\1/p')

cowsay <<MOO

Splunk is available: "${IP}:8000"

MOO
