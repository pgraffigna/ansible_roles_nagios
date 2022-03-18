ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
BRIDGE_INT = "br-mgmt"
IMAGEN = "generic/ubuntu2004"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
 
  config.vm.define :nagios do |n|
    n.vm.box = IMAGEN
    n.vm.hostname = "nagios"
    n.vm.box_check_update = false
    n.vm.network :private_network, :ip => '192.168.60.11', :libvirt__network_name => 'vagrant-libvirt'
     
    n.vm.provider :libvirt do |v|
      v.memory = 2048  
      v.cpus = 2
    end
  end

  config.vm.define :c1 do |c1|
    c1.vm.box = IMAGEN
    c1.vm.hostname = "cliente-01"
    c1.vm.box_check_update = false
    c1.vm.network :private_network, :ip => '192.168.60.12', :libvirt__network_name => 'vagrant-libvirt'
     
    c1.vm.provider :libvirt do |v|
      v.memory = 1024  
      v.cpus = 1
    end
  end
  
  config.vm.define :c2 do |c2|
    c2.vm.box = IMAGEN
    c2.vm.hostname = "cliente-02"
    c2.vm.box_check_update = false
    c2.vm.network :private_network, :ip => '192.168.60.13', :libvirt__network_name => 'vagrant-libvirt'
     
    c2.vm.provider :libvirt do |v|
      v.memory = 1024  
      v.cpus = 1
    end
  end 
end

