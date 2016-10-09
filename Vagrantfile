# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_USERNAME = "vagrant"
VAGRANTFILE_COMMAND = ARGV[0]
VAGRANTFILE_API_VERSION = "2"


# If we're doing anything that provisions or reprovisions machines, we
# need to start new versions of the config files that need to know
# about our VMs.
if  ['up', 'reload', 'provision'].include? VAGRANTFILE_COMMAND
  # Ansible inventory for control machine
  File.open('ansible.hosts', 'w') do |hosts|
    hosts.puts "ansible.vagrant.local ansible_connection=local"
    hosts.puts "[vagrant]"
  end
  # /etc/hosts file for control machine
  File.open('hosts', 'w') do |hosts|
    hosts.puts "127.0.0.1	localhost.localdomain localhost"
  end
  # ~/.ssh/config for vagrant user on control machine
  File.open('ssh.cfg', 'w') do |hosts|
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
  binding.eval(File.read(File.expand_path('hosts.rb')))

  # Build Ansible control machine and run vagrant playbook
  config.vm.define "ansible" do |ansible|
    ansible.vm.provider :virtualbox do |v|
      v.memory = 256
    end
    ansible.vm.hostname = "ansible.vagrant.local"
    ansible.vm.provision "shell",
      path: "scripts/bootstrap.sh", keep_color: "True"
  end

end
