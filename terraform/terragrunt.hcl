locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_vars.yaml", "common_vars.yaml")}"))
}

# Common input variables
inputs = {
  name   = local.common_vars.name
  env    = local.common_vars.env
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = local.common_vars.terraform_state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.common_vars.aws_region
    dynamodb_table = "${local.common_vars.terraform_state_lock_table}-${local.common_vars.name}"
    shared_credentials_file = local.common_vars.aws_credentials
    profile                 = local.common_vars.aws_profile
  }
}