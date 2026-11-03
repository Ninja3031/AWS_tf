output "formatted_project_name" {
  value = local.formatted_project_name
}

output "credentials" {
    value = var.credential
    sensitive = true
}

output "all_locations" {
  value = var.user_locations
}

output "unique_locations" {
  value = local.unique_locations
}


output "positive_cost" {
  value = local.positive_costs
}

output "max_cost" {
  value = local.max_cost
}

output "min_cost" {
  value = local.min_cost
}

output "total_cost" {
  value = local.total_cost
}

output "avg_cost" {
  value = local.avg_cost
}

output "time" {
    value = local.current_timestamp
}

output "config_file_exists" {
    value = local.config_file_exists
}

output "config_data" {
    value = local.config_data
}