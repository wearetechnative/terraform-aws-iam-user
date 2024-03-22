resource "aws_iam_user" "this" {
  name = var.user_name
  path = local.validated_user_path

  force_destroy = true
}

module "policy_helper" {
  source         = "git@github.com:TechNative-B-V/terraform-aws-module-iam-policy-helper.git?ref=ced5ee6d207f723d802b65374804ca7e123f175e"
  principal_type = "user"

  principal_name            = aws_iam_user.this.name
  customer_managed_policies = var.customer_managed_policies
  aws_managed_policies      = var.aws_managed_policies
  assume_role_configuration = var.assume_role_configuration
}
