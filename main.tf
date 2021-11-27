provider "hcloud" {
}

resource "hcloud_ssh_key" "ci" {
  name       = "ci@gitlab.com"
  public_key = file("${path.module}/keys/ci@gitlab.com.pub")
}

resource "hcloud_ssh_key" "mb" {
  name       = "mb@pc0"
  public_key = file("${path.module}/keys/mb@pc0.pub")
}

resource "hcloud_server" "test" {
  name        = "test"
  server_type = "cx11"
  image       = "ubuntu-20.04"
  ssh_keys = [
    hcloud_ssh_key.ci.id,
    hcloud_ssh_key.mb.id
  ]
}
