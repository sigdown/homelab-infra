resource "proxmox_virtual_environment_vm" "k3s_master" {
    name = "k3s-master-1"
    node_name = "pve"
    vm_id = 101

    clone {
        vm_id = 9000
        full = true
    }

    cpu {
        cores = 2
    }

    memory {
        dedicated = 3072
    }

    disk {
        datastore_id = "local-lvm"
        size = 20
        interface = "scsi0"
    }

    network_device {
        bridge = "vmbr0"
    }

    initialization {
        user_account {
            username = "ubuntu"
            keys = [var.ssh_key]
        }
        ip_config {
            ipv4 {
                address = "192.168.1.101/24"
                gateway = "192.168.1.1"
            }
        }
    }
}

resource "proxmox_virtual_environment_vm" "k3s_workers" {
    count = 3
    name = "k3s-worker-${count.index + 1}"
    node_name = "pve"
    vm_id = 102 + count.index

    clone {
        vm_id = 9000
        full = true
    }

    cpu {
        cores = 1
    }

    memory {
        dedicated = 3072
    }

    disk {
        datastore_id = "local-lvm"
        size = 20
        interface = "scsi0"
    }

    network_device {
        bridge = "vmbr0"
    }

initialization {
        user_account {
            username = "ubuntu"
            keys = [var.ssh_key]
        }
        ip_config {
            ipv4 {
                address = "192.168.1.10${count.index + 2}/24"
                gateway = "192.168.1.1"
            }
        }
    }
}