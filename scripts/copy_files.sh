#!/bin/bash

# Fail script on error
set -e

# Find the most recent deployment directory
LATEST_DEPLOY_DIR=$(ls -td /opt/codedeploy-agent/deployment-root/*/ | head -1)

# Copy files from the latest deployment's app folder
cp -r $LATEST_DEPLOY_DIR/deployment-archive/app/* /var/www/html/

echo "Files copied successfully from $LATEST_DEPLOY_DIR"
