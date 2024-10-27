#!/bin/bash

# Update package list and install vim and rsync
apt update && apt install -y vim rsync

# Git stuff
git config --global user.name "" #TODO: git username
git config --global user.email "" #TODO: git email

# Setup vscode things
source /workspace/setup_vscode.sh

# Install Poetry using pip3
pip3 install poetry

# Change to the /root directory
cd /root

# Run the copy.sh script with the 'to_target' argument
bash /workspace/copy.sh to_target

cd /root/taker

# Install dependencies with Poetry
poetry install

# hf and wandb
huggingface-cli login --token #TODO: HF token here
wandb login #TODO: wandb token here

echo "Python stuff installed. enabling jupyter extensions"

jupyter nbextension enable --py widgetsnbextension --sys-prefix

echo "Fresh setup completed successfully."
