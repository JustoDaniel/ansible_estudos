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


variable "startup_script_content" {
  description = "Conteúdo do script de inicialização a ser executado na primeira inicialização da VM."
  type        = string
  default     = null # Por padrão, nenhum script é executado
}