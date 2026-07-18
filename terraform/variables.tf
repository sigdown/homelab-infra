variable "pm_api_token_id" {
  type = string
  sensitive = true 
}

variable "pm_api_token_secret" {
  type = string
  sensitive = true
}

variable "beget_api_token_secret" {
  type = string
  sensitive = true
}

variable "cluster_ssh_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIepO5H73X30fjSJrpFA3qUUYAN0S25/GYnR/0iZKUai home-laptop"
}

variable "edge_ssh_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM5RyWRRUhn9Ojv2AthrPt/mgG6c85VdMAGEg8eqFSWW edge-laptop"
}