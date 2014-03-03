# -*- mode: ruby -*-
# vi: set ft=ruby :
# This is a Vagrant configuration file. It can be used to set up and manage
# virtual machines on your local system or in the cloud. See http://downloads.vagrantup.com/
# for downloads and installation instructions, and see http://docs.vagrantup.com/v2/
# for more information and configuring and using Vagrant.

Vagrant.configure('2') do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'opscode-ubuntu-12.04'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box'

  # This can be set to the host name you wish the guest machine to have. Vagrant
  # will automatically execute the configuration necessary to make this happen.
  config.vm.hostname = 'soso3'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # port 8080 on the virtual machine is forwarded to port 9090 on the host.
  # This will allow the virtual machine to communicate of the common proxy port 8080.
  config.vm.network :forwarded_port, guest: 8080, host: 9090

  config.ssh.forward_agent = true

  # Plugin for managing cookbooks.
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = 'chef/Berksfile'

  # Automatically install chef-client and chef-solo.
  config.omnibus.chef_version = :latest

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    #vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'chef/cookbooks'
    chef.roles_path = 'chef/roles'
    chef.data_bags_path = 'chef/data_bags'

    chef.add_recipe 'apt'
    chef.add_recipe 'git'
    chef.add_recipe 'htop'
    chef.add_recipe 'rvm'
    chef.add_recipe 'postgresql'
    chef.add_recipe 'postgresql::server'
    chef.add_recipe 'postgresql::ruby'
    chef.json = {
        :postgresql => {:password => {:postgres => 'password'}},
        :rvm => {
            :rubies => %w(2.0.0 1.9.3),
            :gems => [
                {name: 'soso3'},
            ],
        },
    }
  end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/iaeste"
  #   chef.validation_client_name = "iaeste-validator"
  #   chef.validation_key_path = ".chef/iaeste-validator.pem"
  # end
end
