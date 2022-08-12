<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_blue-green"></a> [blue-green](#module\_blue-green) | ../blue_green | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | The Role policy for the Principal you want to attach | `string` | `false` | no |
| <a name="input_custom_role_policy_arns"></a> [custom\_role\_policy\_arns](#input\_custom\_role\_policy\_arns) | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | e.g. `prod`, `dev`, `env`) | `string` | n/a | yes |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Max Signed url max time | `number` | `43200` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `Falcon` or `Magicleap`) | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | path to the role | `string` | `"/"` | no |
| <a name="input_product_name"></a> [product\_name](#input\_product\_name) | product\_name (e.g. `Falcon` or `Magicleap`) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of IAM Role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the role. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The ARN Unique ID of IAM Role |
<!-- END_TF_DOCS -->