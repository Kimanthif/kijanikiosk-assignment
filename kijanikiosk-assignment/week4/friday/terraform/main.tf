#########################################
# SECURITY GROUP
#########################################

resource "aws_security_group" "app_sg" {
  name        = "${var.environment}-app-sg"
  description = "Security group for KijaniKiosk servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-app-sg"
  }
}

#########################################
# 3 EC2 MODULES
#########################################

module "api_server" {
  source              = "./modules/app_server"
  server_name         = "api"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  ssh_key_name        = var.ssh_key_name
  security_group_ids  = [aws_security_group.app_sg.id]
}

module "payments_server" {
  source              = "./modules/app_server"
  server_name         = "payments"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  ssh_key_name        = var.ssh_key_name
  security_group_ids  = [aws_security_group.app_sg.id]
}

module "logs_server" {
  source              = "./modules/app_server"
  server_name         = "logs"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  ssh_key_name        = var.ssh_key_name
  security_group_ids  = [aws_security_group.app_sg.id]
}