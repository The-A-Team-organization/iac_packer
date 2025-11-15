#!/bin/bash

set -e

sudo apt install -y wget unzip curl

TERRAGRUNT_VERSION=$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest \
    | grep tag_name | cut -d '"' -f 4)

wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
    -O terragrunt

sudo mv terragrunt /usr/local/bin/
sudo chmod +x /usr/local/bin/terragrunt
