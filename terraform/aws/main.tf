provider "aws" {
  region = var.region
  version = "~> 2.8"
  shared_credentials_file = var.credentials_file
  profile                 = var.profile
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt or via a backend.hcl file
  # https://www.terraform.io/docs/backends/config.html#partial-configuration
  backend "s3" {}
  required_version = ">= 0.12.10"
}
