#!/bin/bash

component=$1
environment=$2
dnf install ansible -y

cd /home/ec2-user
rm -rf ansible-roboshop-roles-tf
git clone https://github.com/Achyut-Ch/ansible-roboshop-roles-tf.git

cd ansible-roboshop-roles-tf
ansible-playbook -e component=$component  -e environment=$environment roboshop.yaml 