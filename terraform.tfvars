# Environment
environment = "production"

# EC2 instance type
instance_type = "t3.micro"

# AWS region
region = "eu-north-1"

# Servers map (3 servers)
servers = {
  api      = { name = "api-server" }
  payments = { name = "payments-server" }
  logs     = { name = "logs-server" }
}

# SSH key name 
ssh_key_name = "terraform-key"

# VPC ID 
vpc_id = "vpc-0f481797dc87df140"

# Your current public IP 
my_ip = "41.90.185.109/32"