#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install Ansible"
#sudo apt-get install software-properties-common -y
#sudo apt-add-repository ppa:ansible/ansible -y
#if [ -f /etc/apt/sources.list.d/ansible-ansible-jessie.list ]; then
#    sudo sed -i 's/jessie/trusty/g' /etc/apt/sources.list.d/ansible-ansible-jessie.list
#fi
#sudo apt-get update
yum install curl ansible -y

title "Install ansible.zsh"
ansible-galaxy install didaktikm.ansible_zsh --force

title "Download playbook to /tmp/zsh.yml"
curl https://raw.githubusercontent.com/didaktikm/ansible.zsh/master/playbook.yml > /tmp/zsh.yml

title "Provision playbook for root"
ansible-playbook -i "localhost," -c local /tmp/zsh.yml

title "Provision playbook for $(whoami)"
ansible-playbook -i "localhost," -c local /tmp/zsh.yml --extra-vars="zsh_user=$(whoami)"
