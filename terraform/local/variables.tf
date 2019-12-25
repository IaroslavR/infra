variable "ip" {
  description = "Docker Swarm manager node IP address"
  type        = string
}

variable "portainer_image" {
  description = "Docker image for portainer"
  type = string
  default = "portainer/portainer:1.23.0"
}