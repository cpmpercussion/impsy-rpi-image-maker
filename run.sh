#!/usr/bin/env bash 
ansible-playbook -i ./hosts.yml ./main.yml --extra-vars="ansible_python_interpreter=$(which python)"
