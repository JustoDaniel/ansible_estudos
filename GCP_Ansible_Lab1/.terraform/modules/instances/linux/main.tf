resource "google_compute_instance" "linux_vm" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Imagem base Debian 11
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

  // Bloco 'metadata' adicionado para o script de inicialização
  metadata = {
    startup-script = var.startup_script_content
  }

  // Permite que o Terraform exclua o disco de boot ao destruir a instância
  allow_stopping_for_update = true
}