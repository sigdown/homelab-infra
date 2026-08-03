output "gateway_ip_address" {
  description = "Home Gateway IP address"
  value       = "192.168.1.100"
}

output "k3s_master_ip_address" {
  description = "K3s master IP address"
  value       =  "192.168.1.101"
}

output "k3s_worker_ip_addresses" {
  description = "K3s worker IP addresses"

  value = [
    "192.168.1.102",
    "192.168.1.103",
    "192.168.1.104",
  ]
}