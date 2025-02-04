# ansible_nagios

Ansible Playbook para desplegar un Servidor Nagios, pnp4nagios para recolectar data y grafana para representarla.

Testeado con Vagrant + qemu + ubuntu_22.04 + ansible_2.10

---

### Descripción

La idea del proyecto es automatizar vía ansible la instalación/configuración de un servicio [nagios](https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html#Ubuntu) para pruebas de laboratorio, el repo cuenta con 3 roles:

1. nagios
2. grafana
3. pnp4nagios

### Dependencias

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)
* [Vagrant](https://developer.hashicorp.com/vagrant/install) (opcional)

### Uso
```shell
git clone https://github.com/pgraffigna/ansible_roles_nagios.git
cd ansible_role_nagios

# para iniciar el despliegue
ansible-playbook main.yml
```

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.