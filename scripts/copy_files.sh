#!/bin/bash
set -e

echo "Copying latest application files..."

SOURCE_DIR=$(find /opt/codedeploy-agent/deployment-root/ -type d -name "deployment-archive" | sort | tail -1)

cp -r $SOURCE_DIR/app/* /var/www/html/

echo "Copy completed."
