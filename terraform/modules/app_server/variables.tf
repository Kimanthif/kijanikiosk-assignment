variable "server_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}