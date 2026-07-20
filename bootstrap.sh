#!/bin/bash

cd terraform/

echo "===Terraform plan==="

terraform plan | grep -E "(# .* will be|Plan:)"

sleep 5

echo "===Terraform apply==="

terraform apply --auto-approve

echo "===Waiting 30 seconds for VM setup==="

sleep 30

cd .. && cd ansible/ 

echo "===Executing site.yml playbook==="

ansible-playbook playbooks/site.yml -e "ansible_user=root" -e "ansible_ssh_common_args="

echo "===Executing tun.yml playbook==="

ansible-playbook playbooks/tun.yml -e "ansible_ssh_common_args="