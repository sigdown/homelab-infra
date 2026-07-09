terraform {
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = "0.50.0"
        }
    }
}

provider "proxmox" {
    endpoint = "https://192.168.1.110:8006"
    api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
    insecure = true
}