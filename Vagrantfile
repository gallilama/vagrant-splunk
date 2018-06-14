# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

#------------------------------------------------------------------------------
# Configuration you may want to modify
#------------------------------------------------------------------------------
VM_NAME = "splunk-sandbox"
VM_MEMORY = 2048
VM_CPUS = 2
# Set to the .deb you're using, and place .deb in the provision/lib directory
SPLUNK_DEB = "splunk-7.1.1-8f0ead9ec3db-linux-2.6-amd64.deb"
# provision/data/*.log are one-shot loaded to this index
SPLUNK_INDEX = "metrics"
# this is the password you will set for your splunk admin user
SPLUNK_PASS  = "P@$$w0rd"
# Splunk home directory
SPLUNK_HOME  = "/opt/splunk"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.network "private_network", ip: "192.168.33.10"
  # You can use public_network, if you prefer:
  # config.vm.network "public_network", bridge: 'en0: Ethernet'
  
  config.vm.provider "virtualbox" do |v|
    v.name = "#{VM_NAME}"
    v.memory = "#{VM_MEMORY}"
    v.cpus = "#{VM_CPUS}"
  end

  config.vm.provision "bootstrap", type: "shell" do |s|
    s.privileged = false
    s.name ="Bootstrap Provisioner"
    s.path = "provision/bin/provision.sh"
    s.env = {
      :SPLUNK_DEB   => "#{SPLUNK_DEB}",
      :SPLUNK_INDEX => "#{SPLUNK_INDEX}",
      :SPLUNK_HOME  => "#{SPLUNK_HOME}",
      :SPLUNK_BIN   => "#{SPLUNK_HOME}/bin/splunk",
      :SPLUNK_PASS  => "#{SPLUNK_PASS}",
      :SPLUNK_AUTH  => "admin:#{SPLUNK_PASS}",
      :DATA_DIR     => '/vagrant/provision/data'
    }
  end
  
  # can be used to restart e.g., vagrant provision --provision-with startup
  config.vm.provision "startup", type: "shell" do |t|
    t.privileged = false
    t.name ="Start up provisioner"
    t.path = "provision/bin/start-splunk.sh"
    t.env = { :SPLUNK_BIN   => "/opt/splunk/bin/splunk" }
  end  
end
