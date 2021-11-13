terraform {
  backend "http" {
    # address, lock_address, unlock_address = CLI arguments, see README.md section Usage
    username = "gitlab-ci-token"
    # password = environment variable TF_HTTP_PASSWORD
    lock_method   = "POST"
    unlock_method = "DELETE"
  }

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.32.0"
    }
  }
}
