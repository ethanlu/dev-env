# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_API_VERSION = "2"

#############################################################################################
#############################################################################################
# environment parameters
unless ENV.key?('VAGRANT_HOST_SYNC_FOLDER')
  raise 'Missing required VAGRANT_HOST_SYNC_FOLDER environment variable!'
end

unless ENV.key?('VAGRANT_GUEST_IP_ADDRESS')
  puts 'Missing optional VAGRANT_GUEST_IP_ADDRESS environment variable! Defaulting to DHCP for guest ip address.'
end

#############################################################################################
#############################################################################################
# START
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(VAGRANT_API_VERSION) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  #############################################################################################
  #############################################################################################
  # vm provider

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos/7"
  config.vm.hostname = "local-vm"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  
  #############################################################################################
  #############################################################################################
  # ssh
  config.ssh.username = "vagrant"
  #config.ssh.password = "vagrant"

  #############################################################################################
  #############################################################################################
  # private network and port forwarding

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  if ENV.key?('VAGRANT_GUEST_IP_ADDRESS')
    config.vm.network "private_network", ip: ENV['VAGRANT_GUEST_IP_ADDRESS']
  else
    config.vm.network "private_network", type: "dhcp"
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # open up 10 ports by default
  for i in 0..9
    host_port = 8080 + i
    guest_port = 80 + i
    config.vm.network "forwarded_port", guest: guest_port, host: host_port
  end
  for i in 0..9
    host_port = 15000 + i
    guest_port = 5000 + i
    config.vm.network "forwarded_port", guest: guest_port, host: host_port
  end
  # open up these for various data stores
  config.vm.network "forwarded_port", guest: 3306, host: 13306
  config.vm.network "forwarded_port", guest: 5432, host: 15432
  config.vm.network "forwarded_port", guest: 5672, host: 15672
  config.vm.network "forwarded_port", guest: 6379, host: 16379

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  #############################################################################################
  #############################################################################################
  # host and guest sync

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # 
  # NOTE: make sure you have vbox guest additionals installed, updated, and matches latest virtualbox
  #
  # custom sync folder
  config.vm.synced_folder ENV['VAGRANT_HOST_SYNC_FOLDER'], "/home/vagrant/sync",
                          type: "virtualbox",
                          owner: "vagrant",
                          group: "vagrant",
                          mount_options: ["dmode=775,fmode=664"]

  # sync folder for saltstack states
  config.vm.synced_folder "salt/states", "/srv/salt",
                          type: "virtualbox",
                          owner: "vagrant",
                          group: "vagrant",
                          mount_options: ["dmode=775,fmode=664"]

  #############################################################################################
  #############################################################################################
  # provisioning

  # saltstack masterless provisioning
  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  #config.vm.provision "shell", path: "configs/os/essentials"
  #config.vm.provision "shell", path: "configs/os/development"
  #config.vm.provision "shell", path: "configs/os/utility"

  #config.vm.provision "shell", path: "configs/webservers/apache"
  #config.vm.provision "shell", path: "configs/webservers/nginx"

  #config.vm.provision "shell", path: "configs/datastores/mysql"
  #config.vm.provision "shell", path: "configs/datastores/postgres"
  #config.vm.provision "shell", path: "configs/datastores/rabbitmq"
  #config.vm.provision "shell", path: "configs/datastores/redis"

  #config.vm.provision "shell", path: "configs/languages/python36"
  #config.vm.provision "shell", path: "configs/languages/php54"
end
