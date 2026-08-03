terraform_dir := "terraform"
ansible_dir := "ansible"

alias destroy := down

up:
    #!/bin/bash
    set -euo pipefail

    terraform -chdir={{ terraform_dir }} apply -auto-approve

    cd {{ ansible_dir }}
    ansible-playbook playbooks/site.yml -e ansible_user=root
    ansible-playbook playbooks/k3s.yml -e ansible_user=root

down:
    terraform -chdir={{ terraform_dir }} destroy -auto-approve

plan:
    terraform -chdir={{ terraform_dir }} plan

apply:
    terraform -chdir={{ terraform_dir }} apply -auto-approve

playbook name:
    cd {{ ansible_dir }} && ansible-playbook playbooks/{{ name }}