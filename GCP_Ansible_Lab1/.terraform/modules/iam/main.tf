resource "google_service_account" "vm_sa" {
  project      = var.project_id
  account_id   = var.account_name
  display_name = "Service Account for Ansible Lab VMs"
}