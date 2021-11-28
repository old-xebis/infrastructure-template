provider "hcloud" {
}

resource "hcloud_server" "test" {
  count       = local.count
  name        = "${local.prefix}test${count.index}"
  server_type = "cx11"
  image       = "ubuntu-20.04"
  user_data   = file("${path.module}/cloud-config.yml")
}
