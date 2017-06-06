#!/bin/bash

echo "Starting mining ${COIN} with ${NB_CPU} CPUs and ${NB_GPU} GPUs"

minergate-cli -user ${USERNAME} ${COIN} ${NB_CPU} ${NB_GPU}

