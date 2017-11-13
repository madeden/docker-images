#!/bin/bash

set -e -u -x

find claymore-miner/ -name "Dockerfile.*" \
	-exec echo "Starting linting " {} \;
	-exec dockerfile_lint -f {} \;

echo "Linted all files with success"

 
