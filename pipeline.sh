#!/bin/bash
set -e   # Exits immediately on error

echo "=== Step 1: Terraform Apply ==="
terraform -chdir=terraform init
terraform -chdir=terraform apply -auto-approve

echo "=== Step 2: Extract IPs and Write Ansible Inventory ==="

API_IP=$(terraform -chdir=terraform output -raw api_server_ip)
PAYMENTS_IP=$(terraform -chdir=terraform output -raw payments_server_ip)
LOGS_IP=$(terraform -chdir=terraform output -raw logs_server_ip)

cat > ansible/inventory.ini <<EOL
[api]
$API_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/${TF_VAR_ssh_key_name}.pem

[payments]
$PAYMENTS_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/${TF_VAR_ssh_key_name}.pem

[logs]
$LOGS_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/${TF_VAR_ssh_key_name}.pem
EOL

echo "=== Step 3: Run Ansible Playbook ==="
ansible-playbook -i ansible/inventory.ini ansible/kijanikiosk.yml