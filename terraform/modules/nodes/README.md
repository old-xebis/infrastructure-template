# Infrastructure Template Terraform Module Node

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.0 |
| hcloud | >= 1.32.0 |

## Providers

| Name | Version |
|------|---------|
| hcloud | 1.44.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_placement_group.nodes-placement-group](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/placement_group) | resource |
| [hcloud_server.nodes-servers](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| image | Name or ID of the image the server is created from. | `string` | `"ubuntu-22.04"` | no |
| labels | User-defined labels (key-value pairs). | `map(string)` | `{}` | no |
| location | The location name to create the server in. | `string` | n/a | yes |
| name\_prefix | Prefix of the resources name to create. | `string` | n/a | yes |
| number | Number of instances to create. | `number` | `0` | no |
| server\_type | Name of the server type this server should be created with. | `string` | `"cx11"` | no |
| user\_data | Cloud-Init user data to use during server creation. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ipv4\_addresses | Nodes public IPv4 addresses |
<!-- END_TF_DOCS -->
