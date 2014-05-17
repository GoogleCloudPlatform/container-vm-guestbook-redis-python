#! /bin/bash

set -e

source config.sh

echo
echo "Setting new manifest.yaml into VM"
gcloud compute instances add-metadata --zone ${ZONE} ${VM_NAME} \
  --metadata-from-file google-container-manifest=manifest.yaml

echo
echo "Rebooting VM to restart containers"
gcloud compute instances reset --zone ${ZONE} ${VM_NAME}

wait_vm_ready