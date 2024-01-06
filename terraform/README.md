# Infrastructure Template Terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.0 |
| hcloud | >= 1.32.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| nodes | ./modules/nodes | n/a |

## Resources

No resources.

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
| nodes\_ipv4\_addresses | Nodes public IPv4 addresses |
<!-- END_TF_DOCS -->
