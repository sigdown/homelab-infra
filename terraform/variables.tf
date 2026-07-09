variable "pm_api_token_id" {
  type = string
  sensitive = true 
}

variable "pm_api_token_secret" {
  type = string
  sensitive = true
}

variable "ssh_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIepO5H73X30fjSJrpFA3qUUYAN0S25/GYnR/0iZKUai home-laptop"
}