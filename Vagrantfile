ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
IMAGEN = "generic/ubuntu2204"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define :nagios do |n|
    n.vm.box = IMAGEN
    n.vm.hostname = "nagios"
    n.vm.box_check_update = false

    n.vm.provider :libvirt do |v|
      v.memory = 2048
      v.disk_bus = 'virtio'
      v.graphics_type = 'none'
      v.cpus = 2
    end
  end
end

