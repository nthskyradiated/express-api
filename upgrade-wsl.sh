#!/bin/bash

# Exit when any command fails
set -e

new_ver=$1

echo "new version: $new_ver"

# Simulate release of the new docker images
docker tag nthskyradiated/argo-express-api:v1.1 nthskyradiated/argo-express-api:$new_ver

# Push new version to dockerhub
docker push nthskyradiated/argo-express-api:$new_ver

# Create temporary folder in Windows TEMP directory
tmp_dir="$(mktemp -d -p /c/Users/${USERNAME}/AppData/Local/Temp)" 
echo "Temporary directory created: $tmp_dir"

# Clone GitHub repo
git clone https://github.com/nthskyradiated/express-api.git "$tmp_dir"

# Update image tag
sed -i "s/nthskyradiated\/argo-express-api:.*/nthskyradiated\/argo-express-api:$new_ver/g" "$tmp_dir/1-deployment.yaml"

# Commit and push changes
cd "$tmp_dir"
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
rm -rf "$tmp_dir"
