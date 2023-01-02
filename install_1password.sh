#!/bin/bash

# Update package list and upgrade installed packages
sudo apt update && sudo apt upgrade -y

# Import the 1Password GPG key and add the 1Password repository to the sources list
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
  sudo tee /etc/apt/sources.list.d/1password.list

# Create the debsig policy directory
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/

# Download the debsig policy file and add it to the policy directory
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
  sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol

# Create the debsig keyring directory and import the 1Password GPG key
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Update package list and install the 1Password CLI
sudo apt update && sudo apt install 1password-cli
