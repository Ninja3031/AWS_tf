variable "environment" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "instance_count" {
  description = "NUmber if Ec2 instances to create"
  type = number

}

variable "monitoring_enabled" {
  description = "Enabled deatiled monitoring for EC2 instance"
  type = bool
  default = true
}

variable "associate_public_ip" {
  description = "Associate public IP address with EC2 instance"
  type = bool
  default = true
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = list(string)
  default = ["10.0.0.0/16", "192.168.0.0/24" , "172.16.0.0/12"]
}

variable "allowed_vm_types" {
  description = "List of allowed VM types"
  type = list(string)
  default = ["t2.micro", "t3.micro", "t3a.micro"]
}

variable "allowed_regions" {
  description = "List of allowed AWS regions"
  type = set(string)
  default = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type = map(string)
  default = {
    Environment = "dev"
    Name        = "dev-Instance"
    created_by = "Terraform"
  }
}

variable "ingress_values" {
  description = "List of ingress values for security group"
  type = tuple([number , string , number])
  default = [443 , "tcp" , 443]
}

variable "config" {
  type = object({
    instance_count = number
    region        = string
    monitoring    = bool
  })
  default = {
    instance_count = 1
    region        = "us-east-1"
    monitoring    = true
  }
}