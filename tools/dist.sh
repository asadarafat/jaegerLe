#!/bin/bash

# Prompt the user for Tag name
read -p "Enter the version Tag: " tag

# Display the entered parameters
echo "Hello, the version Tag tobe used is $tag"

sudo chown -R $(whoami):$(whoami) *

cp go_jaegerle/constants.go go_jaegerle/constants.go.bak
sed -i "s/\(var VersionInfo string = \)\"[^\"]*\"/\1\"$tag\"/" go_jaegerle/constants.go

echo "Cleanup dist folder..."
rm -rRf dist/*

echo "Build Linux Binary..."
GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o jaegerLe go_jaegerle/cmd/main.go 

echo "Copy jaegerLe Binary..."
mv jaegerLe dist/jaegerLe
cp -r config dist

echo "Git Commit and Push with tag $tag"
git add .
git add dist/jaegerLe
git commit -m "commit with tag $tag "
git tag $tag

# Push the commit and the tag to the remote repository
git push origin development --tags


echo "Distribution build done..."