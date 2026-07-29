output "edge_instance_id" {
  description = "Current Beget Edge instance ID"

  value = var.lab_enabled ? beget_compute_instance.edge[0].id : null
}

output "edge_dynamic_ip_address" {
  description = "Dynamic IP assigned directly to the Beget VM"

  value = var.lab_enabled ? beget_compute_instance.edge[0].ip_address : null
}

output "edge_static_ip_address" {
  description = "Persistent Beget additional IP"
  value       = beget_additional_ip.edge_ip.ip_address
}

output "gateway_ip_address" {
  description = "Home Gateway IP address"
  value       = var.lab_enabled ? "192.168.1.100" : null
}

output "k3s_master_ip_address" {
  description = "K3s master IP address"
  value       = var.lab_enabled ? "192.168.1.101" : null
}

output "k3s_worker_ip_addresses" {
  description = "K3s worker IP addresses"

  value = var.lab_enabled ? [
    "192.168.1.102",
    "192.168.1.103",
    "192.168.1.104",
  ] : []
}