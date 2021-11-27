variable "ENV_SLUG" {
  type        = string
  description = "The environment slug, used as name prefix to allow co-existence of multiple environments in one Hetzner Cloud project"
}

locals {
  prefix = "${var.ENV_SLUG}-"
}
