# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "ubuntu1804" do |ub|
    ub.vm.box = "geerlingguy/ubuntu1804"
    ub.vm.network "private_network",ip: "192.168.60.10"
    ub.vm.hostname = "nagios"
  end

  config.vm.provider :virtualbox do |vbox|
    vbox.name = "test-machine"
    vbox.memory = 4096
    vbox.cpus = 2
  end
end



