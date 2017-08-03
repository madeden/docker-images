#!/bin/bash

set -ex

docker run -it \
  -v /usr/lib/nvidia-375/bin:/usr/local/nvidia/bin \
  -v /usr/lib/nvidia-375:/usr/lib/nvidia \
  -v /usr/lib/x86_64-linux-gnu:/usr/lib/cuda \
  -e LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia:/usr/lib/cuda" \
  -e POD_NAME=1nvidia \
  --device /dev/nvidia0:/dev/nvidia0 \
  --device /dev/nvidiactl:/dev/nvidiactl \
  --device /dev/nvidia-uvm:/dev/nvidia-uvm \
  samnco/claymore-miner:9.5-nvidia \
  /entrypoint.sh
