#!/usr/bin/env bash

# Shell provisioner for vagrant-splunk

# Put the name of your .deb here
DEB=splunk-6.2.2-255606-linux-2.6-amd64.deb

PORT=8000

# get the important stuff first!
sudo apt-get install cowsay

# now for Splunk
sudo dpkg -i /vagrant/provision/lib/$DEB

sudo /opt/splunk/bin/splunk start --accept-license

# TODO (galli): Configure Splunk to accept data, and example to oneshot data.

IP=$(ifconfig eth1 | sed -ne 's/.*inet addr:\([0-9.]\+\) .*/\1/p')

cowsay <<MOO
Vagrant box IP: "${IP}"

Splunk is available: "${IP}:${PORT}"

moo!
MOO

