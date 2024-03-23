#!/bin/bash

# Script to update and manage ceremonyclient service
# This script is intended to be run automatically via cronjob

# Navigate to ceremonyclient folder
cd ~/ceremonyclient || { echo "Error: Unable to navigate to ceremonyclient folder"; exit 1; }

# Check if there are new commits on the remote repository
REMOTE_COMMIT=$(git rev-parse origin/master)
LOCAL_COMMIT=$(git rev-parse HEAD)

if [ "$REMOTE_COMMIT" = "$LOCAL_COMMIT" ]; then
    echo "No new commits. Exiting."
    exit 0
fi

# Changes detected, stop the service
echo "Stopping ceremonyclient service..."
if ! service ceremonyclient stop; then
    echo "Error: Failed to stop ceremonyclient service"
    exit 1
fi

# Pull changes
echo "Pulling changes from remote repository..."
if ! git pull origin master; then
    echo "Error: Failed to pull changes from remote repository"
    exit 1
fi

# Navigate to node folder
cd node || { echo "Error: Unable to navigate to node folder"; exit 1; }

# Clean previous build files
echo "Cleaning previous build files..."
GOEXPERIMENT=arenas go clean -v -n -a ./...

# Remove compiled binary file
echo "Removing compiled binary file..."
rm /root/go/bin/node || { echo "Error: Failed to remove compiled binary file"; exit 1; }

# Build new binary file
echo "Building new binary file..."
GOEXPERIMENT=arenas go install ./... || { echo "Error: Failed to build new binary file"; exit 1; }

# Start ceremonyclient service
echo "Starting ceremonyclient service..."
if ! service ceremonyclient start; then
    echo "Error: Failed to start ceremonyclient service"
    exit 1
fi

echo "Script execution completed successfully."
