terraform {}

locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_vars.yaml", "common_vars.yaml")}"))
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  project = local.common_vars.name
  region = local.common_vars.google_region
  credentials_file = local.common_vars.google_credentials
}