#!/bin/bash

# Dynamically find the VS Code CLI
CODE_PATH=$(find /root/.vscode-server -name "code" -type f | grep "bin/remote-cli/code" | head -n 1)

if [ -z "$CODE_PATH" ]; then
    echo "VS Code CLI not found. Please ensure VS Code server is installed."
    exit 1
fi

echo "Found VS Code CLI at: $CODE_PATH"

# Create alias for code command
echo "alias code='$CODE_PATH'" >> /root/.bashrc

# Source .bashrc to make the alias available immediately
source /root/.bashrc

# Verify code command works
if ! $CODE_PATH --version > /dev/null 2>&1; then
    echo "Failed to set up code command. Please check your VS Code server installation."
    exit 1
fi

echo "VS Code CLI set up successfully."

# Install Python extension
$CODE_PATH --install-extension ms-python.python

# Install Jupyter extension
$CODE_PATH --install-extension ms-toolsai.jupyter

echo "Python and Jupyter extensions installed."

echo "Setup complete. Please restart your terminal or run 'source /root/.bashrc' to use the 'code' command."
