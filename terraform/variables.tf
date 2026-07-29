# variables.tf

variable "pm_api_token_id" {
  type      = string
  sensitive = true
}

variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}

variable "beget_api_token_secret" {
  type      = string
  sensitive = true
}

variable "lab_enabled" {
  type    = bool
  default = true
}

variable "cluster_ssh_key" {
  type = string
}

variable "edge_ssh_key" {
  type = string
}