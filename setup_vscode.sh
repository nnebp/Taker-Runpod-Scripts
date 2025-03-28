#!/bin/bash

# Try to find VS Code CLI first
CODE_PATH=$(find /root/.vscode-server -name "code" -type f | grep "bin/remote-cli/code" | head -n 1)

# If VS Code CLI not found, try to find Cursor CLI
if [ -z "$CODE_PATH" ]; then
    echo "VS Code CLI not found, checking for Cursor..."
    CURSOR_PATH=$(find /root/.cursor-server -name "cursor" -type f | grep "bin/remote-cli/cursor" | head -n 1)
    
    if [ ! -z "$CURSOR_PATH" ]; then
        CODE_PATH=$CURSOR_PATH
    fi
fi

if [ -z "$CODE_PATH" ]; then
    echo "Neither VS Code nor Cursor CLI found. Skipping IDE-specific setup."
    exit 0  # Exit with success code to allow the rest of the script to continue
fi

echo "Found IDE CLI at: $CODE_PATH"

# Create alias for code command
echo "alias code='$CODE_PATH'" >> /root/.bashrc

# Source .bashrc to make the alias available immediately
source /root/.bashrc

# Verify code command works
if ! $CODE_PATH --version > /dev/null 2>&1; then
    echo "Failed to set up code command. Skipping IDE-specific setup."
    exit 0  # Exit with success code to allow the rest of the script to continue
fi

echo "IDE CLI set up successfully."

# Install Python extension
$CODE_PATH --install-extension ms-python.python || echo "Failed to install Python extension, continuing..."

# Install Jupyter extension
$CODE_PATH --install-extension ms-toolsai.jupyter || echo "Failed to install Jupyter extension, continuing..."

echo "IDE extensions attempted to install."

echo "Setup complete. Please restart your terminal or run 'source /root/.bashrc' to use the 'code' command."
