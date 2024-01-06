output "environment_slug" {
  value       = local.env.slug
  description = "Environment slug (for debugging)"
}

output "environment_tier" {
  value       = local.env.tier
  description = "Environment tier (for debugging)"
}

output "environment_count" {
  value       = local.count
  description = "Environment specific resource count (for debugging)"
}

output "nodes_ipv4_addresses" {
  value       = module.nodes.ipv4_addresses
  description = "Nodes public IPv4 addresses"
}
