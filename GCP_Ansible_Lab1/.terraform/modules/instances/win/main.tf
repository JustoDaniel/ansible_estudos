resource "google_compute_instance" "windows_vm" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-server-2022-dc-core" # Imagem base Windows Server 2022 Core
    }
  }

  network_interface {
    subnetwork = var.subnet_link
    access_config {
      // Bloco vazio para atribuir um IP público efêmero
    }
  }

  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
  
  allow_stopping_for_update = true
}