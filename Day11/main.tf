locals {
  formatted_project_name = lower(replace(var.project_name, "_", "-"))
  new_tags = merge(var.default_tags, var.environment_tags)

  all_locations = concat(var.user_locations, var.default_locations)

  unique_locations = toset(local.all_locations)

  positive_costs = [for cost in var.monthly_costs : abs(cost)]

  max_cost = max(local.positive_costs...)

  min_cost = min(local.positive_costs...)

  total_cost = sum(local.positive_costs)

  avg_cost = local.total_cost / length(local.positive_costs)

  current_timestamp = timestamp() 

  format1 = formate=date("YYYY-MM-DD", local.current_timestamp)

  config_file_exists = fileexists("./config/config.json")

  config_data = local.config_file_exists ? jsondecode(file("./config/config.json")) : {}
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "project-bucket"

  tags = local.new_tags
}