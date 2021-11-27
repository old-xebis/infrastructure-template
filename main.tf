provider "hcloud" {
}

resource "hcloud_server" "test" {
  name        = "${local.prefix}test"
  server_type = "cx11"
  image       = "ubuntu-20.04"
  user_data   = file("${path.module}/cloud-config.yml")
}
