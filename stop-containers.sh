#! /bin/bash

set -e

source config.sh

echo
echo "Closing firewall for ${VM_NAME}"
gcloud compute firewall-rules delete --quiet ${VM_NAME}-www

echo
echo "Deleting VM: ${VM_NAME}"
gcloud compute instances delete --quiet --zone=${ZONE} ${VM_NAME}


