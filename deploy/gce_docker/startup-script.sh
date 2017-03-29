#! /bin/bash

# [START script]
set -e
set -v

docker pull gcr.io/camhd-image-statistics/camhd-image-statistics

docker run gcr.io/camhd-image-statistics/camhd-image-statistics rake -AT

echo "Startup Complete"
# [END script]
