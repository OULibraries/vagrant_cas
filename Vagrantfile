# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_USERNAME = "vagrant"
#VAGRANTFILE_KEY_PATH = "/home/jsherman/.ssh/id_rsa"
VAGRANTFILE_COMMAND = ARGV[0]
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # General Vagrant VM configuration.
  config.vm.box = "geerlingguy/centos7"
  #config.ssh.insert_key = false
  #config.ssh.private_key_path = VAGRANTFILE_KEY_PATH
  config.ssh.forward_agent = true
  config.vm.network "private_network", type: "dhcp"
  config.vm.provider :virtualbox do |v|
    v.memory = 512
    v.linked_clone = true
  end


  config.vm.provision "shell",
                       path: "scripts/gethostinfo.sh", keep_color: "True",
                       run: "always"


  # write hostfile when provisioning
  if  ['up', 'reload', 'provision'].include? VAGRANTFILE_COMMAND
    # Start new Ansible hosts file for ansible control machine
    File.open('ansible.hosts', 'w') do |hosts|
      hosts.puts "ansible.vagrant.local ansible_connection=local"
      hosts.puts "[vagrant]"
    end
    # Start new hosts file for ansible control machine
    File.open('hosts', 'w') do |hosts|
      hosts.puts "127.0.0.1	localhost.localdomain localhost"
    end
    # Start new ssh.cfg file for ansible control machine
    File.open('ssh.cfg', 'w') do |hosts|
      hosts.puts "Host *.vagrant.local"
      hosts.puts "  StrictHostKeyChecking no"
    end
  end
  # Use a "real" user for interactive logins
  if  ['ssh', 'scp'].include? VAGRANTFILE_COMMAND
    # Maybe you want to set this to a real account
    config.ssh.username = VAGRANTFILE_USERNAME
  end

  
  # Project vms
  binding.eval(File.read(File.expand_path('hosts.rb')))

  # Ansible control vm
  config.vm.define "ansible" do |ansible|
    ansible.vm.provider :virtualbox do |v|
      v.memory = 256
    end
    ansible.vm.hostname = "ansible.vagrant.local"
    ansible.vm.provision "shell",
      path: "scripts/bootstrap.sh", keep_color: "True"
  end

end
