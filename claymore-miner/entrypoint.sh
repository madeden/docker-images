#!/bin/bash

set -ex

trap "echo 'Killed by user action. Exiting gracefully'; exit 0" SIGHUP SIGINT SIGTERM

/claymore/ethdcrminer64 \
  -epool ${EPOOL} \
  -ewal ${EWAL} \
  -eworker ${POD_NAME} \
  -epsw ${EPSW} \
  -esm ${ESM} \
  -etha ${ETHA} \
  -asm ${ASM} \
  -ethi ${ETHI} \
  -gser ${GSER} \
  -mode ${MODE} \
  -di ${DI} \
  -dbg -1

