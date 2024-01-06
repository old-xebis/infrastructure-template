provider "hcloud" {
}

module "nodes" {
  source = "./modules/nodes"

  number = local.count
  name_prefix = "${local.env.slug}-"
  server_type = "cx21"
  image = "ubuntu-22.04"
  location = "nbg1"
  user_data = file("${path.module}/cloud-config.yml")
  labels = {
    "env" = local.env.slug
  }
}
