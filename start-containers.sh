#! /bin/bash

set -e

source config.sh

echo
echo "Opening firewall for tcp:80 to ${VM_NAME}"
gcloud compute firewalls create ${VM_NAME}-www --allow tcp:80 --target-tags ${VM_NAME}

echo
echo "Creating VM: ${VM_NAME}"
gcloud compute instances create ${VM_NAME} \
  --tags ${VM_NAME} \
  --zone ${ZONE}  --machine-type ${MACHINE_TYPE} \
  --image https://www.googleapis.com/compute/v1/projects/google-containers/global/images/container-vm-v20140522 \
  --metadata-from-file google-container-manifest=manifest.yaml

wait_vm_ready
