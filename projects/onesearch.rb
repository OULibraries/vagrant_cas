# See main Vagrantfile for default settings and provisioners

# Solr
config.vm.define( "solr") do |solr|
  solr.vm.hostname = "solr.vagrant.local"
  solr.vm.network "forwarded_port", guest:8443, host:8443
  solr.vm.provider :virtualbox do |v|
    v.memory = 512
  end


end

# Drupal 7
config.vm.define( "d7") do |d7|
  d7.vm.hostname = "d7.vagrant.local"
end

# Nginx
config.vm.define( "nginx") do |nginx|
  nginx.vm.hostname = "nginx.vagrant.local"
  nginx.vm.network "forwarded_port", guest:443, host:64443
end
