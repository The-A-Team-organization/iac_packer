#!/bin/bash

set -e

sudo rm -rf /var/lib/apt/lists/*
sudo apt clean
sudo apt update -y
