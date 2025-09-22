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
  type        = string
  description = "Conteúdo JSON das credenciais do Google Cloud."
  sensitive   = true # MUITO IMPORTANTE para não expor a credencial nos logs!
}