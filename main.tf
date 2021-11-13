provider "hcloud" {
  # Configuration options
}

data "hcloud_locations" "demo" {
}

output "hcloud_locations_demo" {
  value = data.hcloud_locations.demo.names
}
