# Configura o provedor do Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Módulo para criar a identidade (Service Account) para as VMs
module "iam" {
  source       = "./modules/iam"
  project_id   = var.project_id
  account_name = "ansible-lab-vm-sa"
}

# Módulo para criar a rede (VPC), subnet e regras de firewall
module "network" {
  source        = "./modules/network"
  project_id    = var.project_id
  region        = var.region
  network_name  = "ansible-lab-vpc"
  subnet_cidr   = "10.10.0.0/28" # Permite 14 hosts, ideal para os 10 solicitados
  firewall_tags = ["allow-ssh", "allow-rdp-winrm"]
}

# Script para instalar o Ansible em sistemas baseados em Debian/Ubuntu
locals {
  ansible_install_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y software-properties-common
    add-apt-repository --yes --update ppa:ansible/ansible
    apt-get install -y ansible
  EOT
}


# Módulo para criar a VM do Ansible Controller (MODIFICADO)
module "ansible_controller" {
  source                   = "./modules/instances/linux"
  instance_name            = "ansible-controller"
  project_id               = var.project_id
  zone                     = var.zone
  machine_type             = var.machine_types.controller
  subnet_link              = module.network.subnet_link
  service_account          = module.iam.service_account_email
  tags                     = ["allow-ssh"]
  startup_script_content   = local.ansible_install_script # <-- LINHA ADICIONADA
}


# Módulo para criar as 2 VMs Linux gerenciadas
module "linux_nodes" {
  source              = "./modules/instances/linux"
  count               = 2 # Cria 2 instâncias
  instance_name       = "linux-node-0${count.index + 1}"
  project_id          = var.project_id
  zone                = var.zone
  machine_type        = var.machine_types.linux_node
  subnet_link         = module.network.subnet_link
  service_account     = module.iam.service_account_email
  tags                = ["allow-ssh"]
}

/* # Módulo para criar as 2 VMs Windows gerenciadas
module "windows_nodes" {
  source              = "./modules/instances/win"
  count               = 2 # Cria 2 instâncias
  instance_name       = "windows-node-0${count.index + 1}"
  project_id          = var.project_id
  zone                = var.zone
  machine_type        = var.machine_types.windows_node
  subnet_link         = module.network.subnet_link
  service_account     = module.iam.service_account_email
  tags                = ["allow-rdp-winrm"]
}
 */