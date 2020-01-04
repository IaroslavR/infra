output "swarm_manager_ip" {
  value = var.ip
}

output "swarm_worker_token" {
  value = data.local_file.worker_swarm_token.content
}

output "swarm_manager_token" {
  value = data.local_file.manager_swarm_token.content
}
