# Bluestack

Ansible based configuration management

## Setup

* Set up new user
* Run appropriate OVH tasks if needed
* In /etc/sudoers replace

> %sudo ALL=(ALL) ALL

with
> %sudo ALL=(ALL) NOPASSWD:ALL

## TODO

* Fail2ban bug with email in jail.local