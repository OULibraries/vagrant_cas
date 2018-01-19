#!/usr/bin/env python

import json

# Ansible inventory skeleton for Vagrant use
inventory = {
    'vagrant' : {
        'hosts' : [],
    }
}

# Read vagrant hosts file (/etc/hosts format) 
with open( "/vagrant/hosts", "r") as hosts:
    for line in hosts:
        my_host = line.split()[1]
        if( my_host == "localhost.localdomain"): continue
        inventory['vagrant']['hosts'].append(my_host)

print json.dumps(inventory)

