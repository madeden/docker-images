#!/bin/bash

set -ex

docker run -it \
  -v $PWD/config-16cpu.txt:/config/config.txt \
  samnco/xmrminer:0.1.4-cpu \
  /usr/bin/xmr-stak-cpu
