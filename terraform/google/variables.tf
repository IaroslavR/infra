variable "name" {
  description = "Application name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "project" {
  description = "Project name"
}

variable "region" {
  description = "The desired region"
}

variable "credentials_file" {
  description = "Credentials file"
}