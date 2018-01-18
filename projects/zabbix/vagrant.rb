# See main Vagrantfile for default settings and provisioners

# Dev
config.vm.define "dev" do |dev|
  dev.vm.hostname = "dev.vagrant.localdomain"
  dev.vm.network "private_network", ip: "192.168.96.9", :netmask => "255.255.255.0"
end
