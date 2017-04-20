#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/cuda:/usr/lib/nvidia

/claymore/ethdcrminer64 \
	-epool ${EPOOL} \
	-ewal ${EWAL} \
	-eworker ${POD_NAME} \
	-epsw ${EPSW} \
	-esm ${ESM} \
	-ethi ${ETHI} \
	-gser ${GSER} \
	-mode ${MODE} \
	-di ${DI} \
	-dbg -1

