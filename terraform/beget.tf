resource "beget_ssh_key" "edge_key" {
  name       = "edge-laptop"
  public_key = var.edge_ssh_key
}

data "beget_software" "ubuntu" {
  slug = "ubuntu-24-04"
}

resource "beget_compute_instance" "edge" {
  name        = "Edge"
  description = "Edge node for k3s homelab"
  hostname    = "edge-1"
  region      = "ru1"

  configuration = {
    cpu       = 1
    ram_mb    = 1024
    disk_mb   = 10240
    cpu_class = "normal_cpu"
  }

  image = {
    software = {
      id = data.beget_software.ubuntu.id
    }
  }

  access = {
    ssh_keys = [beget_ssh_key.edge_key.id]
  }
}
