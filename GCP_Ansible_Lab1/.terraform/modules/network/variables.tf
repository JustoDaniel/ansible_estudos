variable "project_id" {
  type = string
}
variable "region" {
  type = string
}
variable "network_name" {
  type = string
}
variable "subnet_cidr" {
  type = string
}
variable "firewall_tags" {
  type = list(string)
}