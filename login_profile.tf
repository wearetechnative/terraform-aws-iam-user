resource "aws_iam_user_login_profile" "login_profile" {
  count = var.allow_console_login ? 1 : 0

  user                    = aws_iam_user.this.name
  password_length         = 16
  password_reset_required = true

  lifecycle {
    ignore_changes = [
      password_reset_required
    ]
  }
}
