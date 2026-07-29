resource "local_file" "ansible_inventory" {
  count = var.lab_enabled ? 1 : 0

  filename = "${path.module}/../ansible/inventory.yml"

  content = <<-EOT
all:
  children:
    edge:
      hosts:
        edge-1:
          ansible_host: ${beget_additional_ip.edge_ip.ip_address}
          ansible_user: ubuntu

    home:
      children:
        gateway:
          hosts:
            gateway-1:
              ansible_host: 192.168.1.100
              ansible_user: root

        k3s_masters:
          hosts:
            k3s-master-1:
              ansible_host: 192.168.1.101
              ansible_user: root

        k3s_workers:
          hosts:
            k3s-worker-1:
              ansible_host: 192.168.1.102
              ansible_user: root

            k3s-worker-2:
              ansible_host: 192.168.1.103
              ansible_user: root

            k3s-worker-3:
              ansible_host: 192.168.1.104
              ansible_user: root
  EOT
}