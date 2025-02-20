resource "aws_iam_user" "this" {
  name = var.user_name
  path = local.validated_user_path

  force_destroy = true
}

module "policy_helper" {
  
  source = "git@github.com:wearetechnative/terraform-aws-iam-helper.git?ref=b5e28f28c11fd0f5733f0a0c8ad212bed4b99ff6"
  principal_type = "user"

  principal_name            = aws_iam_user.this.name
  customer_managed_policies = var.customer_managed_policies
  aws_managed_policies      = var.aws_managed_policies
  assume_role_configuration = var.assume_role_configuration
}
