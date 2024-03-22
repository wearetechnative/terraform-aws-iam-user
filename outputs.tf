output "user_initial_password" {
  value = length(aws_iam_user_login_profile.login_profile) > 0 ? aws_iam_user_login_profile.login_profile[0].password : "<console_login_disabled>"
}

output "iam_user_arn" {
  value = aws_iam_user.this.arn
}

output "iam_user_id" {
  value = aws_iam_user.this.id
}