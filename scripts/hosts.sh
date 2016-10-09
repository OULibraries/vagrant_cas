#!/usr/bin/env bash

# Get ip address and hostname, write it to a shared hosts file
IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
HOSTNAME=$(hostname)
echo "${IP}	${HOSTNAME}" >> /vagrant/hosts
