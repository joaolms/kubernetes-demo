variable "location" {
  description = "Região do Azure"
  type        = string
  default     = "eastus2"
}

variable "common_tags" {
  description = "Tags que serão aplicadas à todos os recursos da demo"
  type        = map(string)
  default     = {
    plataforma = "kubernetes-demo"
  }
}

variable "SSH_PUBKEY" {
  description = "Chave pública para conexão SSH"
  type        = string
}
