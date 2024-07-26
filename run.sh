#!/usr/bin/env bash 
ansible-playbook -i ./hosts.yml ./impsy.yml --ask-pass --extra-vars="ansible_python_interpreter=$(which python)"
