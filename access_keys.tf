data "aws_iam_policy_document" "list_keys" {
  statement {
    sid       = "AllowAccessKeyManagement"
    actions   = ["iam:ListAccessKeys"]
    effect    = "Allow"
    resources = [aws_iam_user.this.arn]
  }
}

data "aws_iam_policy_document" "manage_keys" {
  count = var.allow_access_keys ? 1 : 0

  statement {
    sid       = "AllowManagementOfAccessKeys"
    actions   = ["iam:CreateAccessKey", "iam:UpdateAccessKey", "iam:DeleteAccessKey"]
    effect    = "Allow"
    resources = [aws_iam_user.this.arn]
  }
}

data "aws_iam_policy_document" "access_key" {
  source_policy_documents = concat(
    [data.aws_iam_policy_document.list_keys.json]
    , data.aws_iam_policy_document.manage_keys[*].json
  )
}

resource "aws_iam_policy" "access_keys" {
  name = "${var.user_name}-accesskeys"
  # enabling below gives errors like: Error: error reading IAM User Managed Policy Attachment (****fred****:arn:aws:iam::617813585939:policy/fred/fred-read_five): couldn't find resource
  #path   = "/${var.user_name}/"
  description = "Allow user to read and optionally manage access keys for ${var.user_name}. See https://console.aws.amazon.com/iam/home#/users/${var.user_name}?section=security_credentials ."

  policy = data.aws_iam_policy_document.access_key.json
}

resource "aws_iam_user_policy_attachment" "access_keys" {
  user       = var.user_name
  policy_arn = aws_iam_policy.access_keys.arn
}
