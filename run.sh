#!/usr/bin/env bash 
poetry run ansible-playbook -i ./hosts.yml ./main.yml --extra-vars="ansible_python_interpreter=$(which python)" -vvv
