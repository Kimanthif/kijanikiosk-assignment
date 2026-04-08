variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment name (staging/production)"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for Ubuntu"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH keypair name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "my_ip" {
  type        = string
  description = "Your IP for SSH access"
}