# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

vconfig = YAML::load_file("vagrant_riak_config.yml")

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"



  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # Riak Server 1 HTTP interface will bind to this port
  config.vm.network :forwarded_port, guest: 10018, host: 10018, auto_correct: true
  # Riak Server 2 HTTP interface will bind to this port
  config.vm.network :forwarded_port, guest: 10028, host: 10028, auto_correct: true
  # Riak Server 3 HTTP interface will bind to this port
  config.vm.network :forwarded_port, guest: 10038, host: 10038, auto_correct: true


  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # FYI virtualbox provider uses vboxmanage
  config.vm.provider "virtualbox" do |v|
    v.name = "Seven DB Vagrant RiakVM"
    v.customize ["modifyvm", :id, "--memory", 1024, "--cpus", 1]
  end

  #TODO Have not tested this yet
  # Configs for provisioning to Rackspace Cloud
  config.vm.provider :rackspace do |rs|
    rs.username = vconfig['rax_username']
    rs.api_key  = vconfig['rax_api_key']
    rs.flavor   = /1 GB Performance/
    rs.image    = /Ubuntu/
  end


  # Script to setup/bootstrap VM
  config.vm.provision "shell" do |s|
    s.path = "setupRiak.sh"
  end

end
