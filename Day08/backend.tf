terraform {
    backend "s3" {
    bucket       = "terraform-tutorial-20261021"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

