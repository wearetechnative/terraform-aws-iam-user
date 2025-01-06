data "aws_iam_policy_document" "login_credentials" {
  statement {
    sid       = "AllowPasswordChangeOnInitialLogin"
    actions   = ["iam:ChangePassword"]
    effect    = "Allow"
    resources = [aws_iam_user.this.arn]
  }

  statement {
    sid       = "AllowUsertoChangePassword"
    actions   = [
      "iam:GetLoginProfile",
      "iam:GetUser",
      "iam:UpdateLoginProfile"
    ]
    effect    = "Allow"
    resources = [aws_iam_user.this.arn]
  }

  statement {
    sid       = "AllowViewPasswordPolicy"
    actions   = ["iam:GetAccountPasswordPolicy"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "AllowUserMFAManagement"
    actions = [
      "iam:ListMFADevices",
      "iam:EnableMFADevice",
      "iam:DeactivateMFADevice",
      "iam:ResyncMFADevice"
    ]
    effect    = "Allow"
    resources = [aws_iam_user.this.arn]
  }

  statement {
    sid = "AllowListTags"
    actions = [
				"iam:ListInstanceProfileTags",
				"iam:ListMFADeviceTags",
				"iam:ListOpenIDConnectProviderTags",
				"iam:ListPolicyTags",
				"iam:ListRoleTags",
				"iam:ListSAMLProviderTags",
				"iam:ListServerCertificateTags",
				"iam:ListUserTags",
				"iam:Tag*",
				"iam:Untag*",
    ]
    effect    = "Allow"
    resources = [aws_iam_user.this.arn]
  }

  statement {
    sid = "AllowListUsers"
    actions = [
      "iam:ListUsers"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/*"]
  }

  statement {
    sid = "AllowDeviceMFAManagement"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice"
    ]
    effect    = "Allow"
    resources = [join(":", concat(slice(split(":", aws_iam_user.this.arn), 0, 5), ["mfa/*"]))]
  }

  statement {
    sid = "AllowDanglingDeviceMFAManagement"
    actions = [
      "iam:ListVirtualMFADevices"
    ]
    effect    = "Allow"
    resources = [join(":", concat(slice(split(":", aws_iam_user.this.arn), 0, 5), ["mfa/"]))]
  }
}

resource "aws_iam_policy" "login_credentials" {
  name = "${var.user_name}-logincredentials"
  # enabling below gives errors like: Error: error reading IAM User Managed Policy Attachment (****fred****:arn:aws:iam::617813585939:policy/fred/fred-read_five): couldn't find resource
  #path   = "/${var.user_name}/"
  description = "Allow user to manage MFA & password ${var.user_name}. See https://console.aws.amazon.com/iam/home#/users/${var.user_name}?section=security_credentials ."

  policy = data.aws_iam_policy_document.login_credentials.json
}

resource "aws_iam_user_policy_attachment" "login_credentials" {
  user       = var.user_name
  policy_arn = aws_iam_policy.login_credentials.arn
}
