# vagrant-splunk
Ubuntu 14.04 VM with Splunk Enterprise, 2048 GB of RAM and 2 CPUs.

I use Splunk for various problems and research projects.
I find the ability to quickly build an instance of these tools handy
for quick data analysis, or to test out some new configuration ideas.

## Prerequisites
###### Vagrant
Install Vagrant see https://docs.vagrantup.com/v2/installation/index.html

###### Splunk
* Download desired Splunk as Debian package (.deb)
* Place .deb in ./provision/lib
* Update the variable, SPLUNK_DEB, in Vagrantfile with correct file name

## Installation
###### Start box
```Shell
vagrant up
```

## Vagrant Controls
###### Start box
```Shell
vagrant up
```

###### SSH into box
```Shell
vagrant ssh
```
The default password is *vagrant*

###### Suspend and Resume
```Shell
vagrant suspend
vagrant resume
```

###### Tear down box
```Shell
vagrant destroy
```
