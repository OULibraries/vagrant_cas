#!/usr/bin/env bash

HOSTNAME=$(hostname)
echo "${HOSTNAME}" >> /vagrant/project/ansible.hosts
