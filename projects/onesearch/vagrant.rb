# See main Vagrantfile for default settings and provisioners

# Solr
config.vm.define( "solr") do |solr|
  solr.vm.hostname = "solr.vagrant.local"
  solr.vm.network "forwarded_port", guest:8983, host:8983
  solr.vm.provider :virtualbox do |v|
    v.memory = 1024
  end
end

# Drupal 7
config.vm.define( "d7") do |d7|
  d7.vm.hostname = "d7.vagrant.local"
end

# Nginx
config.vm.define( "nginx") do |nginx|
  nginx.vm.hostname = "nginx.vagrant.local"
end
