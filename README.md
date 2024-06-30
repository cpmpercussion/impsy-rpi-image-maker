# impsy-rpi-image-maker

Creates Raspberry Pi OS images for running [IMPSY](https://github.com/cpmpercussion/imps).

This repo just contains Ansible playbooks for constructing an image. The process uses [pi-ci](https://github.com/ptrsr/pi-ci/) an emulated Raspberry Pi environment. You should probably look at that repo to understand how this works.

The playbooks originated with [pi-ci](https://github.com/ptrsr/pi-ci/)'s examples.

Most likely, the latest IMPSY image will be available as a release from this repo. It should be compatible with Raspberry Pis 3, 4, 5 and Zero 2 W.

You can run the ansible playbook with:

```
ansible-playbook -i ./hosts.yml ./main.yml
```

### Bits and bops I might need:

```
#!/usr/bin/env python3
```