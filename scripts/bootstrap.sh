#!/usr/bin/env bash

# we need git and ansible to get started
yum install -y git
yum install -y ansible

# copy hosts file provided by vagrant provisioner
cp /vagrant/hosts /etc/hosts
cp /vagrant/ssh.cfg /home/vagrant/.ssh/config
chown vagrant:vagrant /home/vagrant/.ssh/config
chmod 600 /home/vagrant/.ssh/config

# ansible complains if these files are on the windows share because permissions
#cp /vagrant/ansible.hosts /etc/ansible/hosts
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg
#chmod -x /etc/ansible/hosts

# Install ansible roles
ansible-galaxy install -r /vagrant/requirements.yml --force

# run ansible
sudo -u vagrant bash -c "
# Keep colors intact
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=1
ansible-playbook /vagrant/${1}"
