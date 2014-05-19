# Container VM Guestbook

This is a sample on how to use container VMs for a simple guestbook.

There are 2 containers that get deployed into one VM:

  * A Redis database.  This is uses the [dockerfile/redis](https://index.docker.io/u/dockerfile/redis/) container image.
  * An simple python application (based on Flask) that implements the guestbook. The source is included at the root of this repo and is pushed to [jbeda/redis-guestbook](https://index.docker.io/u/jbeda/redis-guestbook/) on the Docker Index.

## Launching
To launch simply have `gcloud compute` configured (see the [Cloud SDK](https://developers.google.com/cloud/sdk/)) with a GCE enabled project and your credentials.  Then run `start-containers.sh` script.  There is no need to have docker installed on your development machine and this *should* work from a Mac.

This will create a new VM called `containervm-guestbook` running the 2 containers described above.  The containers that are running in the VM are specified in `manifest.yaml`.  It may take a while to get up and running as the container image must be downloaded from the docker registry.

## Restarting the containers
Running `restart-containers.sh` will upload the latest version of `manifest.yaml` and reboot the VM.  On the second boot the new manifest will be read and executed.

## Cleaning up
To clean up the VM, simply run `stop-vm.sh`.  This will delete the VM and its root disk.  Any data on the VM will be lost!

## Modifying the application

  1. Have Docker installed on a development workstation.  You can use a GCE instance for this.  See instructions [here](http://docs.docker.io/installation/google/).
  1. Create an account on [index.docker.io](https://index.docker.io) and run `docker login`.
  1. Build your application with `docker build -t <username>/redis-guestbook`.
  1. Push your application with `docker push <username>/redis-guestbook`.
  1. Modify `manifest.yaml` to refer to your new application.
  1. Start up a new VM with `start-containers.sh` or reload you rexisting one with `restart-containers.sh`.
