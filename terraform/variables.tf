variable "ENV_SLUG" {
  type        = string
  description = "The environment slug, used to prefix resource names to allow co-existence of multiple environments in one Hetzner Cloud project"

  validation {
    condition     = can(regex("^[0-9a-z]+((?:-|[0-9a-z]+)*[0-9a-z]+)*$", var.ENV_SLUG))
    error_message = "The ENV_SLUG can contain only `a-z`, `0-9`, and `-`. No leading / trailing `-`."
  }

  validation {
    condition     = length(var.ENV_SLUG) <= 24
    error_message = "The ENV_SLUG must be 24 characters long or shorter."
  }
}

variable "ENV_TIER" {
  type        = string
  default     = ""
  description = "The environment tier, used to determine amount of resources for each environment"

  validation {
    condition     = contains(["", "production", "staging", "testing", "development", "other"], var.ENV_TIER)
    error_message = "The ENV_TIER value must be one of \"production\", \"staging\", \"testing\", \"development\", or \"other\"."
  }
}

locals {
  env = {
    slug = var.ENV_SLUG
    tier = var.ENV_TIER != "" ? var.ENV_TIER : substr(var.ENV_SLUG, 0, 10) == "production" ? "production" : substr(var.ENV_SLUG, 0, 7) == "staging" ? "staging" : substr(var.ENV_SLUG, 0, 7) == "testing" ? "testing" : substr(var.ENV_SLUG, 0, 11) == "development" ? "development" : "other"
  }
  count = contains(["production", "staging"], var.ENV_TIER) ? 0 : 1
}
