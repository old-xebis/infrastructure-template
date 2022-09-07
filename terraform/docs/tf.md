# Infrastructure Template Terraform Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.0 |
| hcloud | 1.32.0 |

## Providers

| Name | Version |
|------|---------|
| hcloud | 1.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_server.test](https://registry.terraform.io/providers/hetznercloud/hcloud/1.32.0/docs/resources/server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ENV\_SLUG | The environment slug, used to prefix resource names to allow co-existence of multiple environments in one Hetzner Cloud project | `string` | n/a | yes |
| ENV\_TIER | The environment tier, used to determine amount of resources for each environment | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| environment\_count | Environment specific resource count (for debugging) |
| environment\_slug | Environment slug (for debugging) |
| environment\_tier | Environment tier (for debugging) |
| hcloud\_server\_test\_ipv4\_address | Test server public IPv4 address |
| hcloud\_server\_test\_name | Test server name |
<!-- END_TF_DOCS -->
