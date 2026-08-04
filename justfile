terraform_dir := "terraform"
ansible_dir := "ansible"

alias destroy := down

init:
    terraform -chdir= {{ terraform_dir }} init

up:
    #!/bin/bash
    set -euo pipefail

    terraform -chdir={{ terraform_dir }} apply -auto-approve

    cd {{ ansible_dir }}
    
    ansible-playbook playbooks/wait_for_nodes.yml -e ansible_user=root
    ansible-playbook playbooks/site.yml -e ansible_user=root
    ansible-playbook playbooks/k3s.yml -e ansible_user=root

down:
    terraform -chdir={{ terraform_dir }} destroy -auto-approve

plan:
    terraform -chdir={{ terraform_dir }} plan

apply:
    terraform -chdir={{ terraform_dir }} apply -auto-approve

play name:
    #!/bin/bash
    set -euo pipefail

    cd {{ ansible_dir }}
    ansible-playbook playbooks/wait_for_nodes.yml
    ansible-playbook playbooks/{{ name }}