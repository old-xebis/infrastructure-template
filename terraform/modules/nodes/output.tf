output "ipv4_addresses" {
  value       = hcloud_server.nodes-servers[*].ipv4_address
  description = "Nodes public IPv4 addresses"
}
