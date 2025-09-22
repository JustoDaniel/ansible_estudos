variable "project_id" {
  type = string
}
variable "instance_name" {
  type = string
}
variable "machine_type" {
  type = string
}
variable "zone" {
  type = string
}
variable "subnet_link" {
  type = string
}
variable "service_account" {
  type = string
}
variable "tags" {
  type = list(string)
}