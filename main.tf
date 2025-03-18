resource "aws_iam_user" "this" {
  name = var.user_name
  path = local.validated_user_path

  force_destroy = true
  tags = {}

  lifecycle {
    ignore_changes = [
      tags 
    ]
  }
}

module "policy_helper" {
  
  source = "github.com/wearetechnative/terraform-aws-iam-helper.git?ref=a6525c6df24080263b16efda52f4be20267f4513"
  principal_type = "user"

  principal_name            = aws_iam_user.this.name
  customer_managed_policies = var.customer_managed_policies
  aws_managed_policies      = var.aws_managed_policies
  assume_role_configuration = var.assume_role_configuration
}
