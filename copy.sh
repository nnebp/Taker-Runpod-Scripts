#!/bin/bash

# Define the directories
WORKSPACE_DIR="/workspace/taker"
TARGET_DIR="/root/taker"

# Function to copy code from the target directory to the workspace directory
copy_to_workspace() {
	echo "Copying code from $TARGET_DIR to $WORKSPACE_DIR..."
	rsync -av "$TARGET_DIR/" "$WORKSPACE_DIR/"
}

# Function to copy code from the workspace directory to the target directory
copy_to_target() {
	echo "Copying code from $WORKSPACE_DIR to $TARGET_DIR..."
	rsync -av "$WORKSPACE_DIR/" "$TARGET_DIR/"
}

# Argument handling
if [ "$1" == "to_workspace" ]; then
	copy_to_workspace
elif [ "$1" == "to_target" ]; then
	copy_to_target
else
	echo "Usage: $0 {to_workspace|to_target}"
	exit 1
fi

echo "Copy operation completed successfully."
