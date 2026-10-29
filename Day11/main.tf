locals {
  formatted_project_name = lower(replace(var.project_name, "_", "-"))
  new_tags = merge(var.default_tags, var.environment_tags)
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "project-bucket"

  tags = local.new_tags
}