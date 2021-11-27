output "environment_slug" {
  value       = var.ENV_SLUG
  description = "Environment slug (for debugging)"
}

output "hcloud_server_test_ipv4_address" {
  value       = hcloud_server.test.ipv4_address
  description = "Test server public IPv4 address"
}
