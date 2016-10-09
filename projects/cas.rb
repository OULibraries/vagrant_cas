# See main Vagrantfile for default settings and provisioners

# CAS
config.vm.define "cas" do |cas|
  cas.vm.hostname = "cas.vagrant.local"
  cas.vm.network "forwarded_port", guest:8443, host:8443
end

# Drupal 7
config.vm.define "d7" do |d7|
  d7.vm.hostname = "d7.vagrant.local"
end

# Nginx
config.vm.define "nginx" do |nginx|
  nginx.vm.hostname = "nginx.vagrant.local"
  nginx.vm.network "forwarded_port", guest:443, host:64443
end
