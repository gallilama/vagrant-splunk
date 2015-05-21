# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "public_network", bridge: 'en0: Ethernet'

  config.vm.provider "virtualbox" do |v|
    v.name = "vagrant-splunk"
    v.memory = 2048
    v.cpus = 2
    # comment gui out if you don't want it
    v.gui = true
  end

  config.vm.provision "shell" do |s|
    s.privileged = false
    s.path = "provision/bin/provision.sh"
  end

end
