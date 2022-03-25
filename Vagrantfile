# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"

  priv_ip = "192.168.33.40"
  config.vm.network "private_network", ip: priv_ip

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.cpus = 1
    vb.memory = "4096"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/sway_desktop.yaml"
    ansible.inventory_path = "ansible/hosts.yaml"
    ansible.limit = priv_ip
    # ansible.vault_password_file = ".ansible_vault_password"
    ansible.verbose = true
    # ansible.galaxy_role_file = "requirements.yaml"
  end
end
