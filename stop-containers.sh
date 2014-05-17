#! /bin/bash

set -e

source config.sh

echo
echo "Closing firewall for containervm-guestbook"
gcloud compute firewalls delete --quiet ${VM_NAME}-www

echo
echo "Deleting containervm-guestbook VM"
gcloud compute instances delete --quiet --zone=${ZONE} ${VM_NAME}


