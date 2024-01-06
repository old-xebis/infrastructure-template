resource "hcloud_placement_group" "nodes-placement-group" {
  name = "nodes-placement-group"
  type = "spread"
  labels = var.labels
}

resource "hcloud_server" "nodes-servers" {
  count = var.number
  name = "${var.name}${count.index}"
  server_type = var.server_type
  image = var.image
  location = var.location
  user_data = var.user_data
  placement_group_id = hcloud_placement_group.nodes-placement-group.id
  labels = var.labels
}
