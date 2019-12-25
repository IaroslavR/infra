terraform {}

locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_vars.yaml", "common_vars.yaml")}"))
}

# Include all settings from the parent terragrunt.hcl files
include {
  path = find_in_parent_folders()
}

inputs = {
  ip = local.common_vars.docker_swarm_manager_ip
}