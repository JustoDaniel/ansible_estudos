variable "project_id" {
  description = "O ID do projeto GCP onde os recursos serão criados."
  type        = string
  default     = "terraform-teste-projeto01"
}

variable "region" {
  description = "A região onde os recursos serão criados."
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "A zona onde as instâncias de computação serão criadas."
  type        = string
  default     = "us-east1-c"
}

variable "machine_types" {
  description = "Mapa com os tipos de máquina para cada role no laboratório."
  type = map(string)
  default = {
    controller = "e2-medium"
    linux_node = "e2-small"
    windows_node = "e2-small"
  }
}

variable "GOOGLE_CREDENTIALS" {
  description = "Credenciais JSON da conta de serviço do Google Cloud."
  type        = string
  sensitive   = true // Muito importante para credenciais, para não exibi-las nos logs.
}
