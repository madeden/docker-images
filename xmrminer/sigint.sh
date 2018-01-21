#!/bin/bash

set -ex

trap "echo 'Killed by user action. Exiting gracefully'; exit 0" SIGHUP SIGINT SIGTERM

[ ! -f $PWD/config.txt ] && { 
  echo "Cannot find configuration file. Exiting gracefully"
  exit 0
}

/usr/local/bin/xmr-stak
