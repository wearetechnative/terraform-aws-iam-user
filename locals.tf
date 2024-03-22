locals {
  compact_user_path   = compact(split("/", var.user_path))
  validated_user_path = length(local.compact_user_path) > 0 ? format("/%s/", join("/", local.compact_user_path)) : "/"
}
