# resource "aws_instance" "example" {
#   ami           = var.ami
#   instance_type = var.allowed_vm_types[1]

#   tags = var.tags

#   lifecycle {
#     create_before_destroy = true
#     prevent_destroy       = false
#   }
# }

# resource "aws_launch_template" "app_server" {
#   name_prefix   = "app-server-"
#   image_id      = var.ami
#   instance_type = var.allowed_vm_types[1]

#   tag_specifications {
#     resource_type = "instance"

#     tags = var.tags
#   }
# }

# #Auto Scaling Group

# resource "aws_autoscaling_group" "app_servers" {
#   name                      = "app-servers-asg"
#   max_size                  = 3
#   min_size                  = 1
#   desired_capacity          = 2
#   health_check_type         = "EC2"
#   availability_zones         = ["us-east-1a", "us-east-1b" , "us-east-1c"]

#   launch_template {
#     id      = aws_launch_template.app_server.id
#     version = "$Latest"
#   }

#   tag {
#     key                 = "Name"
#     value               = "app-server"
#     propagate_at_launch = true
#   }

#   tag {
#     key                 = "Demo"
#     value               = "ignore_changes"
#     propagate_at_launch = false
#   }

#   #lifecycle Rule : Ignore changes to derired_capacity
#   #This is useful when auto-scaling policies or external systems modify the desired capacity of the group, and you want to prevent Terraform from reverting those changes during subsequent applies.
#   #Terraform wonr try to revert capacity changes made outside of Terraform, allowing the auto-scaling group to scale based on its policies without interference from Terraform.
#   lifecycle {
#     ignore_changes = [desired_capacity]
#   }  
# }


# Security Group
# resource "aws_security_group" "app_sg" {
#   name        = "app-security-group"
#   description = "Security group for application servers"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Allow HTTP from anywhere"
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Allow HTTPS from anywhere"
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Allow all outbound traffic"
#   }

#   tags = var.tags
# }

# # EC2 Instance that gets replaced when security group changes
# resource "aws_instance" "app_with_sg" {
#   ami                    = data.aws_ami.amazon_linux_2.id
#   instance_type          = var.allowed_vm_types[0]
#   vpc_security_group_ids = [aws_security_group.app_sg.id]

#   tags = var.tags

#   # Lifecycle Rule: Replace instance when security group changes
#   # This ensures the instance is recreated with new security rules
#   lifecycle {
#     replace_triggered_by = [
#       aws_security_group.app_sg.id
#     ]
#   }
# }

data "aws_region" "current" {}

resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "compliance-bucket-${var.environment}-${var.region}"

  tags = var.tags

  # Lifecycle Rule: Validate bucket has required tags after creation
  # This ensures compliance with organizational tagging policies
  lifecycle {
    postcondition {
      condition     = contains(keys(var.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag for audit purposes!"
    }
  }
}

