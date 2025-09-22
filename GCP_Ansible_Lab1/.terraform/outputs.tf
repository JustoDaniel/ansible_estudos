output "ansible_controller_ip" {
  description = "Endereço IP público do Ansible Controller."
  value       = module.ansible_controller.public_ip
}

output "linux_nodes_ips" {
  description = "Endereços IP públicos dos nós Linux."
  value       = module.linux_nodes[*].public_ip
}

output "windows_nodes_ips" {
  description = "Endereços IP públicos dos nós Windows."
  value       = module.windows_nodes[*].public_ip
}

output "instrucoes_windows" {
  description = "Instruções para obter a senha inicial do Windows."
  value       = "Para obter a senha de uma instância Windows, vá ao Console do GCP, selecione a VM, clique em 'Definir senha do Windows' e anote a senha gerada."
}