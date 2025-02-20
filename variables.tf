variable "user_name" {
  description = "User name for new user. Required value."
  type        = string
}

variable "user_path" {
  description = "Path for new user. Defaults to \"/\"."
  type        = string
  default     = "/"
}

variable "customer_managed_policies" {
  description = "Optional map of customer managed policy names. Key is policyname and value is policy object in HCL."
  type        = any # activate below when optional is ready for GA
  # type = map(object({
  #   Version = string
  #   Sid = optional(string)
  #   Statement = list(object({
  #     Sid = optional(string)
  #     Effect = string
  #     Action = list(string)
  #     Resource = list(string)
  #     Condition = optional(any)
  #   }))
  # }))
  default = {}
}

variable "aws_managed_policies" {
  description = "Optional list of AWS managed policies. We assume that these policies already exist."
  type        = list(string)
  default     = []
}

variable "assume_role_configuration" {
  description = "Policies for assume role. Optional."
  type = map(object({
    account_id = string
    role_path  = string
  }))
  default = {}
}

variable "allow_access_keys" {
  description = "Allow self management of access keys."
  type        = bool
  default     = false
}

variable "allow_console_login" {
  description = "Allow console access."
  type        = bool
  default     = false
}

variable "password_reset_required" {
  description = "Require password reset on next login."
  type = bool
  default = false
}