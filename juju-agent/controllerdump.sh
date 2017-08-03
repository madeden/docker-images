#!/bin/bash

#!/bin/bash

set -x

trap "echo 'Killed by user action. Exiting gracefully'; exit 0" SIGHUP SIGINT SIGTERM

[ -d "${TARGET_DIR}" ] && { 
  echo "Found backup folder ${TARGET_DIR}. Proceeding..."
} || { 
  echo "Cannot find backup folder. Creating it..."
  mkdir -p "${TARGET_DIR}"
}

echo "Ready to perform operation for controller"
# Switching to the target model
juju switch controller || { 
  echo "The model controller does not exist. Exiting with error"
  exit 1
}

# Download
echo "Downloading backup for ${APPLICATION}, unit ${UNIT} in model controller to ${TARGET_DIR}"
juju create-backup --filename "${TARGET_DIR}/${PREFIX}-controller-$(date +%Y%m%d%H).tgz" || { 
  echo "Failed to download backup. Exiting."
  exit 1
}

exit 0