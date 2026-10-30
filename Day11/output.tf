output "formatted_project_name" {
  value = local.formatted_project_name
}

output "credentials" {
    value = var.credential
    sensitive = true
}