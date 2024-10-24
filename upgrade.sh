#!/bin/bash

# exit when any command fails
set -e

new_ver=$1

echo "new version: $new_ver"

# Simulate release of the new docker images
docker tag nthskyradiated/v1.0 nthskyradiated/express-ts-api:$new_ver

# Push new version to dockerhub
docker push nthskyradiated/express-ts-api:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
git clone https://github.com/nthskyradiated/express-api.git $tmp_dir

# Update image tag
sed -i '' -e "s/nthskyradiated\/express-ts-api:.*/nthskyradiated\/express-ts-api:$new_ver/g" $tmp_dir/my-app/1-deployment.yaml

# Commit and push
cd $tmp_dir
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
rm -rf $tmp_dir
