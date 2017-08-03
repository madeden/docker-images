#!/bin/bash

set -ex

docker run -it \
  -v $PWD/config-16cpu.txt:/config/config.txt \
  -e VERSION=cpu \
  samnco/xmrminer:0.1.5-cpu \
  /usr/bin/xmr-stak-sigint
