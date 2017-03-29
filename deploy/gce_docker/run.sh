#!/usr/bin/bash

set -e
set -v

echo "=== Running script ==="

/usr/share/google/dockercfg_update.sh

docker pull gcr.io/camhd-image-statistics/camhd-image-statistics

if [ -d image_statistics_experiment ]; then
  cd image_statistics_experiment && git pull origin master
else
  git clone https://github.com/CamHD-Analysis/image_statistics_experiment
fi

docker images

docker run --rm -v ~/image_statistics_experiment:/opt/image_statistics_experiment \
            gcr.io/camhd-image-statistics/camhd-image-statistics \
            ls -al
