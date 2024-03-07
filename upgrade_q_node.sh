#!/bin/bash

# Navigate to ceremonyclient folder
cd ~/ceremonyclient

# Check for changes in the git repository
git fetch origin

# Check if there are changes
if ! git diff --quiet origin/master; then
    # Changes detected, stop the service
    service ceremonyclient stop
    
    # Merge changes
    git merge origin
    
    # Navigate to node folder
    cd node
    
    # Clean previous build files
    GOEXPERIMENT=arenas go clean -v -n -a ./...
    
    # Remove compiled binary file
    rm /root/go/bin/node
    
    # Build new binary file
    GOEXPERIMENT=arenas go install ./...
    
    # Start Q Node
    service ceremonyclient start
else
    echo "No changes in the repository. Exiting."
    exit 0
fi

