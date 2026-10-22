locals {
  bucket_name = "${var.channel_name}-bucket-${var.environment}-${var.region}-20261022"
  vpc_name    = "${var.environment}-VPC"
}