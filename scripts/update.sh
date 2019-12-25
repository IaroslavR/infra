#!/usr/bin/env bash

# Terraform
wget -O tmp.zip https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip && \
  unzip -o tmp.zip -d /home/iaro/opt/ && \
  rm tmp.zip  && \
  sudo ln -sf /home/iaro/opt/terraform /usr/bin/terraform  && \
  terraform -version