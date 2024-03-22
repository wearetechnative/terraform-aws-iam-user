output "user_initial_password" {
  value = length(aws_iam_user_login_profile.login_profile) > 0 ? aws_iam_user_login_profile.login_profile[0].password : "<console_login_disabled>"
}
