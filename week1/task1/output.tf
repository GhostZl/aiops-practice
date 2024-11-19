output "cvm_public_ip" {
  value = module.cvm.public_ip
}

output "ssh_password" {
  value = var.password
}
