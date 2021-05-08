variable "location" {
  description = "Região do Azure"
  type        = string
  default       = "brazilsouth"
}

variable "subnet_names" {
  description   = "Lista de nomes para cada subnet e deve conter a mesma quantidade de elementos da variável subnet_prefixes."
  type          = list(string)
  default       = [ "snet-pub", "snet-priv" ]
}

variable "subnet_prefixes" {
  description   = "Lista de prefixos de subnet que serão criados, deve conter a mesma quantidade de elementos da variáviel subnet_names."
  type          = list(string)
  default       = [ "10.100.0.0/23", "10.100.2.0/23" ]
}
