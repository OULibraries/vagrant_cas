# See main Vagrantfile for default settings and provisioners

# Zabbix
config.vm.define "zabbix" do |dev|
  dev.vm.hostname = "zabbix.vagrant.localdomain"
  dev.vm.network "private_network", ip: "192.168.96.11", :netmask => "255.255.255.0"
end
