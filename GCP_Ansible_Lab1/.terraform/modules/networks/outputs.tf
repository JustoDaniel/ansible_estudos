output "network_name" {
  value = google_compute_network.vpc.name
}
output "subnet_link" {
  value = google_compute_subnetwork.subnet.self_link
}