#! /bin/bash

set -e

source config.sh

echo
echo "Opening firewall for containervm-guestbook"
gcloud compute firewalls create ${VM_NAME}-www --allow tcp:80 --target-tags ${VM_NAME}

echo
echo "Creating containervm-guestbook VM"
gcloud compute instances create ${VM_NAME} \
  --tags ${VM_NAME} \
  --zone ${ZONE}  --machine-type ${MACHINE_TYPE} \
  --image projects/google-containers/global/images/containervm-v20140514 \
  --metadata-from-file google-container-manifest=manifest.yaml

wait_vm_ready