# Cria a VPC (Virtual Private Cloud)
resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
}

# Cria a Subnet na VPC
resource "google_compute_subnetwork" "subnet" {
  project                  = var.project_id
  name                     = "${var.network_name}-subnet"
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.self_link
}

# Regra de Firewall para permitir SSH (porta 22)
resource "google_compute_firewall" "allow_ssh" {
  project     = var.project_id
  name        = "${var.network_name}-allow-ssh"
  network     = google_compute_network.vpc.self_link
  direction   = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"] # AVISO: Aberto para a internet. Ideal para laboratórios.
  target_tags   = ["allow-ssh"]
}

# Regra de Firewall para permitir RDP (3389) e WinRM (5985, 5986)
resource "google_compute_firewall" "allow_rdp_winrm" {
  project     = var.project_id
  name        = "${var.network_name}-allow-rdp-winrm"
  network     = google_compute_network.vpc.self_link
  direction   = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["3389", "5985", "5986"]
  }
  source_ranges = ["0.0.0.0/0"] # AVISO: Aberto para a internet. Ideal para laboratórios.
  target_tags   = ["allow-rdp-winrm"]
}

# Regra de Firewall para permitir comunicação interna total na VPC
resource "google_compute_firewall" "allow_internal" {
  project     = var.project_id
  name        = "${var.network_name}-allow-internal"
  network     = google_compute_network.vpc.self_link
  direction   = "INGRESS"
  allow {
    protocol = "all"
  }
  source_ranges = [var.subnet_cidr] # Permite comunicação entre todas as VMs na subnet
}