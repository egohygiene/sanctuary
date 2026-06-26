#!/bin/bash

# Open ports for samba communication.

sudo ufw allow 137/tcp
sudo ufw allow 138/tcp
sudo ufw allow 139/tcp

# Restart firewall.
sudo ufw disable
sudo ufw reload
sudo ufw disable
sudo ufw enable
