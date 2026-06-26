#!/usr/bin/env bash

install_dependencies() {
  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo -y
}

add_gcloud_distribution_uri() {
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
  sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
}

import_gcloud_public_key() {
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
}

install_gcloud_cli() {
  sudo apt-get update && \
  sudo apt-get install google-cloud-sdk
}

initialize_gcloud() {
  gcloud init
}

main() {
  install_dependencies
  add_gcloud_distribution_uri
  import_gcloud_public_key
  install_gcloud_cli
  initialize_gcloud
}

main
