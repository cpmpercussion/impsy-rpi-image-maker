# impsy-rpi-image-maker

This repo has tools and instructions to create Raspberry Pi OS images for running [IMPSY](https://github.com/cpmpercussion/imps).

This repo just contains Ansible playbooks for setting up a fresh image running on a Raspberry Pi.

Ideally the setup could be done on an emulated Raspberry Pi in a Docker container (e.g., using [pi-ci](https://github.com/ptrsr/pi-ci/)), but that's a bit hard so far. For now we have instructions for a physical Raspberry Pi.

The releases contain images that can be used to get an IMPSY system up and running quickly. The iamge should be compatible with Raspberry Pis 3, 4, 5 and Zero 2 W.

You can flash the custom image to an SD card using [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

## Setting up the starting image and Raspberry Pi

You'll need a Raspberry Pi 4 or 5 (suggested, although 3 and Zero 2 W may technically work) and a 16GB SD card (it's better not to use a huge SD card to save time when copying it).

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

That's it! That should take a while, go get a coffee.

## Save SD card image and compress it

Once you have verified that everything is working, time to suck off this image, basically following [these instructions](https://github.com/monsieurborges/raspberry-pi/blob/master/setup/clone-sd-card.md).

1. Shutdown the Raspberry Pi (gracefully), take out the SD card and plug it into a computer

2. Save the SD filesystem to a `.img` file: 

  - On MacOS I find out the `/dev/diskX` entry with `diskutil list`

  - Then, unmount the disk: `diskutil unmountDisk /dev/diskX`

  - Then I extract the image with `time sudo gdd if=/dev/rdiskX of=./impsy.img bs=16M status=progress && sync` (N.B. `rdisk` for "raw disk").

3. Use [PiShrink](https://github.com/Drewsif/PiShrink) to compress the image from the docker image `monsieurborges/pishrink`

  - `docker run --privileged=true --rm --volume $(pwd):/workdir monsieurborges/pishrink pishrink -Zv impsy.img impsy-shrunk.img`

The final `impsy-shrunk.img.xz` file is ready for release.

## Flashing the SD card image

To install on a Raspberry Pi:

1. download one of the `.img.xz` images from the [releases area](https://github.com/cpmpercussion/impsy-rpi-image-maker/releases)

2. open Raspberry Pi Imager, select `Use custom` under Operating System, then flash to your SD card. Select `no` for applying custom settings (unless you want to, but not sure if it works or is useful..)

3. put the SD card into a Raspberry Pi and boot it up

> N.B.: Experience seems to show that the image works best on the second boot, and that slower Raspberry Pis (3B+, Zero 2 W), will take quite a while to boot up. Remember that the blinking light on Raspberry Pi indicates disk access.

## More and references.

For more information on using IMPSY, see the [main repo](https://github.com/cpmpercussion/imps), or the [workshop site](https://smcclab.github.io/nime-embedded-ai/)

