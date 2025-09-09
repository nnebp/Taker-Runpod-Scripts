#!/bin/bash

# Update package list and install vim and rsync
apt update && apt install -y vim rsync

# Get GitHub username
read -p "Enter your GitHub username: " github_username

# Git stuff
git config --global user.name "$github_username"
git config --global user.email "$github_username@users.noreply.github.com"

# Setup vscode things
source ./setup_vscode.sh

# Install Poetry using pip3
pip3 install poetry

# Change to the /root directory
cd /root

# Clone taker from GitHub instead of copying
git clone https://github.com/nickypro/taker.git

cd /root/taker

# Create examples directory if it doesn't exist
mkdir -p examples

# Clone investigating-ablation repository into examples directory
cd examples
git clone https://github.com/nickypro/investigating-ablation.git

# Switch to comparison branch in investigating-ablation repo
cd investigating-ablation
git checkout comparison

# Return to taker directory
cd /root/taker

# Install dependencies with Poetry
poetry install

echo "Python stuff installed. enabling jupyter extensions"

jupyter nbextension enable --py widgetsnbextension --sys-prefix

echo "Fresh setup completed successfully." 