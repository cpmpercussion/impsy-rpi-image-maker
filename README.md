# impsy-rpi-image-maker

This repo has tools and instructions to create Raspberry Pi OS images for running [IMPSY](https://github.com/cpmpercussion/imps).

This repo just contains Ansible playbooks for setting up a fresh image running on a Raspberry Pi.

Ideally the setup could be done on an emulated Raspberry Pi in a Docker container (e.g., using [pi-ci](https://github.com/ptrsr/pi-ci/)), but that's a bit hard so far. For now we have instructions for a physical Raspberry Pi.

The releases contain images that can be used to get an IMPSY system up and running quickly. The iamge should be compatible with Raspberry Pis 3, 4, 5 and Zero 2 W.

You can flash the custom image to an SD card using [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

## Setting up the starting image and Raspberry Pi

You'll need a Raspberry Pi 4 or 5 (suggested, although 3 and Zero 2 W may technically work) and an SD card of at least 16GB.

1. Download the [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

2. Under the Operating System drop down, select `Raspberry Pi OS (other)` and then `Raspberry Pi OS Lite (64-bit)` "A port of Debian Bookworm" (these instructions tested with the 2024-07-04 release).

3. Under the storage dropdown select your SD card

4. Click `NEXT`.

5. In the "Use OS customisation?" window, click `EDIT SETTINGS`.

6. Set the `GENERAL` settings as follows:

- Set hostname `impsypi.local`
- Set username and password:
  - Username: `pi`
  - Password: `raspberry` (or your choice of another password, but you will need to remember it)
- (you can also set up wireless LAN here if you want, not mandatory) 

7. Set the `SERVICES` settings as follows:

- Check `Enable SSH` and select `Use password authentication`

8. Save the settings, click `YES` to apply custom settings and `NEXT` to start writing the SD card.

9. Put the SD card into a Raspberry Pi and connect it to a network that you can access. You will need to check that you can connect to the Raspberry Pi at `pi@impsypi.local` via SSH.

Once you've completed these steps, you can continue to install IMPSY and configure the Raspberry Pi.

## Installing IMPSY and setup

This part of the guide uses Ansible to install:

- poetry, IMPSY, and it's dependencies on the Raspberry Pi
- setup IMPSY to run at boot 
- configure the Raspberry Pi to enable ethernet over USB port, so we can connect to it later without an ethernet cable

Once you have setup the host Raspberry Pi, connect it to a network (easiest to use ethernet, not wifi) and ensure than you can login at `pi@impsypi.local` via SSH.

You will need to ensure that you have installed `ansible` and `sshpass` in order to complete the next step.

1. Run the ansible tasks with `ansible-playbook -i ./hosts.yml ./impsy.yml --ask-pass`

That's it! That should take a while but it's fairly easy.

## Save SD card image and compress it



But, in order to make sure the right python packages are available, it's probably easier to use Poetry to manage a virtual environment as explained below.


## Install and running:

There's a `pyproject.toml` file to handle the python dependencies.

1. You can install the virtualenv and dependencies with `poetry install`
2. You can run the ansible playbooks with `poetry run ./run.sh`

## Bits and bops I might need:

- location that runs poetry's python3: `#!/usr/bin/env python3`
- might need to make the timeout longer, 300s is not long enough for the docker contained to start maybe?
- test logging into the docker container via ssh.
