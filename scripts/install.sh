#!/usr/bin/env bash

# Google Cloud cli
sudo audo apt update && apt install  apt-transport-https - y
# https://cloud.google.com/sdk/docs/downloads-apt-get
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk -y
# gcloud init

# AWS cli
conda install awscli
# Utils
conda install httpie -c conda-forge