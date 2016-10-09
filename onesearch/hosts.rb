  # Solr
  config.vm.define( "solr") do |solr|
    solr.vm.hostname = "solr.vagrant.local"
    solr.vm.network "forwarded_port", guest:8443, host:8443
    solr.vm.provision "shell",
      path: "scripts/gethostinfo.sh", keep_color: "True",
      run: "always"
  end

  # Drupal 7
  config.vm.define( "d7") do |d7|
    d7.vm.hostname = "d7.vagrant.local"
    d7.vm.provision "shell",
      path: "scripts/gethostinfo.sh", keep_color: "True",
      run: "always"
  end

  # Nginx
  config.vm.define( "nginx") do |nginx|
    nginx.vm.hostname = "nginx.vagrant.local"
    nginx.vm.network "forwarded_port", guest:443, host:64443
    nginx.vm.provision "shell",
      path: "scripts/gethostinfo.sh", keep_color: "True",
      run: "always"
  end
