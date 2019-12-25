terraform {
  # The configuration for this backend will be filled in by Terragrunt or via a backend.hcl file
  # https://www.terraform.io/docs/backends/config.html#partial-configuration
  backend "s3" {}
  required_version = ">= 0.12.10"
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  version = "~> 3.3"
}

data "google_client_config" "current" {}

//resource "google_kms_key_ring" "my_key_ring" {
//  project  = "my-project"
//  name     = "my-key-ring"
//  location = "us-central1"
//}
//
//resource "google_kms_crypto_key" "my_crypto_key" {
//  name     = "my-crypto-key"
//  key_ring = google_kms_key_ring.my_key_ring.self_link
//}