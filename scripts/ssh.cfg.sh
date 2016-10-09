#!/usr/bin/env bash

# Write ssh config file
HOSTNAME=$(hostname)
VAGRANTNAME=$(hostname | cut -d"." -f 1)
echo "Host ${HOSTNAME}" >> /vagrant/ssh.cfg
echo "  IdentityFile /vagrant/.vagrant/machines/${VAGRANTNAME}/virtualbox/private_key" >> /vagrant/ssh.cfg
