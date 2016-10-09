#!/usr/bin/env bash

HOSTNAME=$(hostname)
echo "${HOSTNAME}" >> /vagrant/ansible.hosts
