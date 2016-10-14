# -*- mode: ruby -*-
# vi: set ft=ruby :

##### Config

VAGRANTFILE_USERNAME = "lmc"
VAGRANTFILE_PLAYBOOK = "project/playbooks/vagrant.yml"
VAGRANTFILE_HOSTSRB = "project/vagrant.rb"

##### End of Config

VAGRANTFILE_COMMAND = ARGV[0]
VAGRANTFILE_API_VERSION = "2"
VAGRANTFILE_PATH = File.dirname(__FILE__)

# If we're doing anything that provisions or reprovisions machines, we
# need to start new versions of the config files that need to know
# about our VMs.
if  ['up', 'reload', 'provision'].include? VAGRANTFILE_COMMAND
  # Ansible inventory for control machine
  File.open(VAGRANTFILE_PATH+'/project/ansible.hosts', 'w') do |hosts|
    hosts.puts "ansible.vagrant.local ansible_connection=local"
    hosts.puts "[vagrant]"
  end
  # /etc/hosts file for control machine
  File.open(VAGRANTFILE_PATH+'/hosts', 'w') do |hosts|
    hosts.puts "127.0.0.1	localhost.localdomain localhost"
  end
  # ~/.ssh/config for vagrant user on control machine
  File.open(VAGRANTFILE_PATH+'/ssh.cfg', 'w') do |hosts|
    hosts.puts "Host *.vagrant.local"
    hosts.puts "  StrictHostKeyChecking no"
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Default configuration for all VMs
  config.vm.box = "geerlingguy/centos7"
  config.ssh.forward_agent = true
  config.vm.network "private_network", type: "dhcp"
  config.vm.provider :virtualbox do |v|
    v.memory = 512
    v.linked_clone = true
  end

  # All VMs should report in so we can configure them with ansible
  config.vm.provision "shell",
                      path: "scripts/gethostinfo.sh",
                      keep_color: "True",
                      run: "always"

  # Use a "real" user for interactive logins
  if  ['ssh', 'scp'].include? VAGRANTFILE_COMMAND
    # Maybe you want to set this to a real account
    config.ssh.username = VAGRANTFILE_USERNAME
  end
  
  # Load and build project VMs
  # Use binding.eval to make sure that we're in the right scope.
  binding.eval(File.read(File.expand_path(VAGRANTFILE_PATH+'/'+ VAGRANTFILE_HOSTSRB)))

  # Build Ansible control machine and run vagrant playbook
  config.vm.define "ansible" do |ansible|
    ansible.vm.hostname = "ansible.vagrant.local"
    ansible.vm.provider :virtualbox do |v|
      v.memory = 256  # Keeping overhead low
      v.cpus = 1
    end
    ansible.vm.provision "shell",
                         path: "scripts/bootstrap.sh",
                         keep_color: "True",
                         args: VAGRANTFILE_PLAYBOOK
  end
end
