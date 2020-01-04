terraform {
  # The configuration for this backend will be filled in by Terragrunt or via a backend.hcl file
  # https://www.terraform.io/docs/backends/config.html#partial-configuration
  backend "s3" {}
  required_version = ">= 0.12.10"
}

// https://stackoverflow.com/a/46730848/4249707
resource "null_resource" "docker_swarm" {

  provisioner "local-exec" {
    command = "docker swarm init --advertise-addr ${var.ip} && sleep 5 && docker swarm update --task-history-limit 0 && docker swarm join-token worker -q > ${path.cwd}/data/worker_swarm_token.txt && docker swarm join-token manager -q > ${path.cwd}/data/manager_swarm_token.txt"
  }

  provisioner "local-exec" {
    command = "docker swarm leave --force"
    when    = destroy
  }
  triggers = {
    ip = var.ip
  }
}

data "local_file" "worker_swarm_token" {
  filename   = "${path.cwd}/data/worker_swarm_token.txt"
  depends_on = [null_resource.docker_swarm]
}

data "local_file" "manager_swarm_token" {
  filename   = "${path.cwd}/data/manager_swarm_token.txt"
  depends_on = [null_resource.docker_swarm]
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_network" "public" {
  name   = "public"
  driver = "overlay"
  attachable = true
  internal = false
  depends_on = [null_resource.docker_swarm]
}
