#!/bin/bash

set -ex

docker run -it \
  -v $PWD/config.2cpu:/config/config.txt \
  -e VERSION=cpu \
  samnco/xmrminer:1.5.0-cpu \
  /usr/bin/xmr-stak-sigint
