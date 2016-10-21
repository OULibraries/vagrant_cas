# See main Vagrantfile for default settings and provisioners

# CAS
config.vm.define "cas" do |cas|
  cas.vm.hostname = "cas.vagrant.localdomain"
  cas.vm.network "forwarded_port", guest:8443, host:8443
  cas.vm.provider :virtualbox do |v|
    v.memory = 1024
  end
end

# Drupal 7
config.vm.define "d7" do |d7|
  d7.vm.hostname = "d7.vagrant.localdomain"
end

# Nginx
config.vm.define "nginx" do |nginx|
  nginx.vm.hostname = "nginx.vagrant.localdomain"
  nginx.vm.network "forwarded_port", guest:443, host:64443
end
