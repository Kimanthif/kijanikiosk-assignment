output "api_server_ip" {
  value       = module.api_server.public_ip
  description = "API server public IP"
}

output "payments_server_ip" {
  value       = module.payments_server.public_ip
  description = "Payments server public IP"
}

output "logs_server_ip" {
  value       = module.logs_server.public_ip
  description = "Logs server public IP"
}

output "ssh_commands" {
  value = {
    api      = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${module.api_server.public_ip}"
    payments = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${module.payments_server.public_ip}"
    logs     = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${module.logs_server.public_ip}"
  }
}