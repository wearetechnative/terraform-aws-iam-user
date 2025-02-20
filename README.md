# Terraform AWS [iam-user]

This module implements a simple user module that allows the user to create their own credentials and assign MFA.

[![](we-are-technative.png)](https://www.technative.nl)

## How does it work

### First use after you clone this repository or when .pre-commit-config.yaml is updated

Run `pre-commit install` to install any guardrails implemented using pre-commit.

See [pre-commit installation](https://pre-commit.com/#install) on how to install pre-commit.

## Usage

To use this module ...

```hcl
module "iam_user" {
  source   = "git@github.com:TechNative-B-V/terraform-aws-module-iam-user.git?ref=HEAD"

  user_name = "example@example.com"
  user_path = "/example_path/"

  customer_managed_policies = {
    "website_codebuild_cloudwatch": jsondecode(data.aws_iam_policy_document.website_codebuild_cloudwatch.json)
  }
  aws_managed_policies      = [ "AdministratorAccess" ]

  assume_role_configuration = { "example": { "account_id" : 123123123, "role_path" : "/role/path/to/assume/role_name" } }

  allow_access_keys         = false
  allow_console_login = true
}

data "aws_iam_policy_document" "website_codebuild_cloudwatch" {
  statement {
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [ "arn:${data.aws_partition.current.id}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/website_stack_website_*" ]
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_helper"></a> [policy\_helper](#module\_policy\_helper) | git@github.com:wearetechnative/terraform-aws-iam-helper.git | b5e28f28c11fd0f5733f0a0c8ad212bed4b99ff6 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.access_keys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.login_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_login_profile.login_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_iam_user_policy_attachment.access_keys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_policy_attachment.login_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.list_keys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.login_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.manage_keys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_access_keys"></a> [allow\_access\_keys](#input\_allow\_access\_keys) | Allow self management of access keys. | `bool` | `false` | no |
| <a name="input_allow_console_login"></a> [allow\_console\_login](#input\_allow\_console\_login) | Allow console access. | `bool` | `false` | no |
| <a name="input_assume_role_configuration"></a> [assume\_role\_configuration](#input\_assume\_role\_configuration) | Policies for assume role. Optional. | <pre>map(object({<br>    account_id = string<br>    role_path  = string<br>  }))</pre> | `{}` | no |
| <a name="input_aws_managed_policies"></a> [aws\_managed\_policies](#input\_aws\_managed\_policies) | Optional list of AWS managed policies. We assume that these policies already exist. | `list(string)` | `[]` | no |
| <a name="input_customer_managed_policies"></a> [customer\_managed\_policies](#input\_customer\_managed\_policies) | Optional map of customer managed policy names. Key is policyname and value is policy object in HCL. | `any` | `{}` | no |
| <a name="input_password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | Require password reset on next login. | `bool` | `false` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | User name for new user. Required value. | `string` | n/a | yes |
| <a name="input_user_path"></a> [user\_path](#input\_user\_path) | Path for new user. Defaults to "/". | `string` | `"/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | n/a |
| <a name="output_iam_user_id"></a> [iam\_user\_id](#output\_iam\_user\_id) | n/a |
| <a name="output_user_initial_password"></a> [user\_initial\_password](#output\_user\_initial\_password) | n/a |
<!-- END_TF_DOCS -->
