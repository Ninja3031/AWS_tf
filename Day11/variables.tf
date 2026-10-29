variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "MyProject_Aadiraj"
}

variable "default_tags" {
  default = {
    company    = "MyCompany"
    managed_by = "Terraform"
  }
}

variable "environment_tags" {
  default = {
    environment = "production"
    cost_center = "cc-123"
  }
}