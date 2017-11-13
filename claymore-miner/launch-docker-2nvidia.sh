#!/bin/bash

set -ex

docker run -it \
  -v /usr/lib/nvidia-384/bin:/usr/local/nvidia/bin \
  -v /usr/lib/nvidia-384:/usr/lib/nvidia \
  -v /usr/lib/x86_64-linux-gnu:/usr/lib/cuda \
  -e LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia:/usr/lib/cuda" \
  -e POD_NAME=2nvidia \
  --device /dev/nvidia1:/dev/nvidia1 \
  --device /dev/nvidia0:/dev/nvidia0 \
  --device /dev/nvidiactl:/dev/nvidiactl \
  --device /dev/nvidia-uvm:/dev/nvidia-uvm \
  samnco/claymore-miner:9.7-nvidia \
  /entrypoint.sh
