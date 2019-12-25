terraform {}

locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_vars.yaml", "common_vars.yaml")}"))
}

# Include all settings from the parent terragrunt.hcl files
include {
  path = find_in_parent_folders()
}

inputs = {
  region = local.common_vars.aws_region
  credentials_file = local.common_vars.aws_credentials
  profile = local.common_vars.aws_profile
  tags = {
    Application = local.common_vars.name
    Environment = local.common_vars.env
  }
}