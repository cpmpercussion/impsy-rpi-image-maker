# impsy-rpi-image-maker

Creates Raspberry Pi OS images for running [IMPSY](https://github.com/cpmpercussion/imps).

This repo just contains Ansible playbooks for constructing an image. The process uses [pi-ci](https://github.com/ptrsr/pi-ci/) an emulated Raspberry Pi environment. You should probably look at that repo to understand how this works.

The playbooks originated with [pi-ci](https://github.com/ptrsr/pi-ci/)'s examples.

Most likely, the latest IMPSY image will be available as a release from this repo. It should be compatible with Raspberry Pis 3, 4, 5 and Zero 2 W.

In short, you can run the ansible playbook with:

```
ansible-playbook -i ./hosts.yml ./main.yml
```

## Install and running:

There's a `pyproject.toml` file to handle the python dependencies.

1. You can install the virtualenv and dependencies with `poetry install`
2. You can run the ansible playbooks with `./run.sh`

## Bits and bops I might need:

- location that runs poetry's python3: `#!/usr/bin/env python3`
- might need to make the timeout longer, 300s is not long enough for the docker contained to start maybe?
- test logging into the docker container via ssh.
