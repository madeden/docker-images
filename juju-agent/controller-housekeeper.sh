#!/bin/bash

set -x

trap "echo 'Killed by user action. Exiting gracefully'; exit 0" SIGHUP SIGINT SIGTERM

HISTORY=$1

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

# Cleaning up on the controller
for i in $(seq 1 1 ${HISTORY})
do
	juju backups | sort -r | tail -n1 | xargs juju remove-backup || {
		echo "backup does not exist or failed to delete"
	}
done

# Cleaning up locally
find ${TARGET_DIR} -name "${PREFIX}-controller-*" | sort -r | tail -n+${HISTORY} | xargs rm -f

exit 0