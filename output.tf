output "environment_slug" {
  value       = var.ENV_SLUG
  description = "Environment slug (for debugging)"
}

output "environment_tier" {
  value       = var.ENV_TIER
  description = "Environment tier (for debugging)"
}

output "environment_count" {
  value       = local.count
  description = "Environment specific resource count (for debugging)"
}

output "hcloud_server_test_name" {
  value       = length(hcloud_server.test) > 0 ? hcloud_server.test[0].name : null
  description = "Test server name"
}

output "hcloud_server_test_ipv4_address" {
  value       = length(hcloud_server.test) > 0 ? hcloud_server.test[0].ipv4_address : null
  description = "Test server public IPv4 address"
}
