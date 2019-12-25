variable "name" {
  description = "Application name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "credentials_file" {
  description = "Path to the credentials file"
  type        = string
}

variable "profile" {
  type        = string
  description = "AWS profile to use"
}

variable "tags" {
  description = "Map of key-value pairs to use for tags"
  type        = map(string)
}