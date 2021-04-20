# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "xv6_box"
    vb.memory = 1024
    vb.cpus = "2"
  end
  config.vm.provision "shell", path: "provision.sh"
end
