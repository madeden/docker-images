#!/bin/bash

#!/bin/bash

set -x

trap "echo 'Killed by user action. Exiting gracefully'; exit 0" SIGHUP SIGINT SIGTERM

[ "${APPLICATION}" = "easyrsa" ] || {
  echo "this script is made for easyrsa only. Please adjust ENV"
  exit 1
}

juju run --unit=${APPLICATION}/${UNIT} "sudo rm -f /home/ubuntu/pki.tgz" || {
  echo "Failed to cleanup backup"
}

[ -d "${TARGET_DIR}" ] && { 
  echo "Found backup folder ${TARGET_DIR}. Proceeding..."
} || { 
  echo "Cannot find backup folder. Creating it..."
  mkdir -p "${TARGET_DIR}"
}

echo "Ready to perform operation for application ${APPLICATION}, unit ${UNIT} in model ${MODEL}"
# Switching to the target model
juju switch ${MODEL} || { 
  echo "The model ${MODEL} does not exist. Exiting with error"
  exit 1
}

# Execute 
echo "Generating backup for ${APPLICATION}, unit ${UNIT} in model ${MODEL}"
juju run --unit=${APPLICATION}/${UNIT} \
  'sudo tar cfz /home/ubuntu/pki.tgz $(sudo find /var/lib/juju/agents -name pki -type d) && sudo chown ubuntu:ubuntu /home/ubuntu/pki.tgz' \
  || { 
    echo "Failed to generate backup. Exiting."
    exit 1
  }

# Wait until the file is completed (arbitrarily 1min)
sleep 10

# Download
echo "Downloading backup for ${APPLICATION}, unit ${UNIT} in model ${MODEL} to ${TARGET_DIR}"
juju scp ${APPLICATION}/${UNIT}:/home/ubuntu/pki.tgz "${TARGET_DIR}/${PREFIX}-${MODEL}-$(date +%Y%m%d%H).tgz" || { 
  echo "Failed to download backup. Exiting."
  exit 1
}

exit 0