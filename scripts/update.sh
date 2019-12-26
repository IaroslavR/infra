#!/usr/bin/env bash

I_PATH=/home/iaro/opt/
TERRAGRUNT=https://github.com/gruntwork-io/terragrunt/releases/download/v0.21.10/terragrunt_linux_amd64
TERRAFORM=https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip


# Terraform
wget -O tmp.zip $TERRAFORM && \
  unzip -o tmp.zip -d $I_PATH && \
  rm tmp.zip  && \
  sudo ln -sf ${I_PATH}terraform /usr/bin/terraform  && \
  terraform -version

# Terragrunt
wget -O ${I_PATH}terragrunt $TERRAGRUNT && \
  sudo ln -sf ${I_PATH}terragrunt /usr/bin/terragrunt  && \
  terragrunt -version