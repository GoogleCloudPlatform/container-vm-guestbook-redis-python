# Container VM Guestbook

This is a sample on how to use container VMs for a simple guestbook.  You can read more about containers on GCE [here](https://developers.google.com/compute/docs/containers).

There are 2 containers that get deployed into one VM:

  * A Redis database.  This uses the [dockerfile/redis](https://index.docker.io/u/dockerfile/redis/) container image.
  * A simple python application (based on Flask) that implements the guestbook. The source is included at the root of this repo and is pushed to [google/guestbook-python-redis](https://index.docker.io/u/google/guestbook-python-redis/) on the Docker Index.

## Launching
To launch simply have `gcloud compute` configured (see the [Cloud SDK](https://developers.google.com/cloud/sdk/)) with a GCE enabled project and your credentials.  There is no need to have Docker installed on your workstation/development machine.

Either run the `start-containers.sh` shell script or run the following commands:

```
VM_NAME=container-vm-guestbook
gcloud compute firewalls create ${VM_NAME}-www --allow tcp:80 --target-tags ${VM_NAME}

gcloud compute instances create ${VM_NAME} \
  --tags ${VM_NAME} \
  --zone us-central1-a  --machine-type n1-standard-1 \
  --image https://www.googleapis.com/compute/v1/projects/google-containers/global/images/container-vm \
  --metadata-from-file google-container-manifest=manifest.yaml
```

This will create a new VM called `containervm-guestbook` running the 2 containers described above.  We also open up the firewall to just this VM so that you can reach the web server running on it.  The containers that are running in the VM are specified in `manifest.yaml`.  It may take a while to get up and running as the container image must be downloaded from the docker registry.

Just hit the public IP of the VM with your web browser to access the guest book.

## Restarting the containers
If you want to change the manifest and reload it, the easiest thing to do is to upload a new manifest and restart the VM hosting the containers.

You can run the `restart-containers.sh` script or run the following commands:
```
gcloud compute instances add-metadata --zone us-central1-a ${VM_NAME} \
  --metadata-from-file google-container-manifest=manifest.yaml

gcloud compute instances reset --zone us-central1-a ${VM_NAME}
```

## Cleaning up
To clean up the VM, simply run `stop-containers.sh`.  This will delete the VM and its root disk.  Any data on the VM will be lost!

Or run the following commands:
```
gcloud compute firewalls delete --quiet ${VM_NAME}-www

gcloud compute instances delete --quiet --zone=us-central1-a ${VM_NAME}
```

## Modifying the application

  1. Have Docker installed on a development workstation.  You can use a GCE instance for this.  See instructions [here](http://docs.docker.io/installation/google/).
  1. Build your application with (this project should match where you plan to create the VM):
  
     ```
     docker build -t gcr.io/<your-project-id>/guestbook-python-redis .
	 ```
  1. Push your application to the [Google Container Registry](https://gcr.io) with:
  
     ```
	 gcloud preview docker push gcr.io/<your-project-id>/guestbook-python-redis
	 ```
  1. Modify `manifest.yaml` to refer to use `gcr.io/<your-project-id>/guestbook-python-redis` in place of `google/guestbook-python-redis`.
  1. Start up a new VM with `start-containers.sh` or reload you rexisting one with `restart-containers.sh`.
