#!/bin/bash

# Variables
WINDOWS_IP="<WindowsIP>"
SMB_CREDENTIALS="/home/<YourUsername>/.smbcredentials"
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Create the .smbcredentials file
echo "username=share" > $SMB_CREDENTIALS
echo "password=<YourPassword>" >> $SMB_CREDENTIALS

# Secure the .smbcredentials file
chmod 600 $SMB_CREDENTIALS

# Create mount points
sudo mkdir -p /mnt/windows_c
sudo mkdir -p /mnt/windows_d
sudo mkdir -p /mnt/windows_f
sudo mkdir -p /mnt/windows_g
sudo mkdir -p /mnt/windows_z

# Backup current fstab
sudo cp /etc/fstab /etc/fstab.bak

# Add entries to fstab
echo "//$WINDOWS_IP/CShare /mnt/system cifs credentials=$SMB_CREDENTIALS,iocharset=utf8,vers=3.0,uid=$USER_ID,gid=$GROUP_ID,rw,suid,dev,exec,auto,nofail,nouser,async 0 0" | sudo tee -a /etc/fstab
echo "//$WINDOWS_IP/DShare /mnt/emulation cifs credentials=$SMB_CREDENTIALS,iocharset=utf8,vers=3.0,uid=$USER_ID,gid=$GROUP_ID,rw,suid,dev,exec,auto,nofail,nouser,async 0 0" | sudo tee -a /etc/fstab
echo "//$WINDOWS_IP/FShare /mnt/files cifs credentials=$SMB_CREDENTIALS,iocharset=utf8,vers=3.0,uid=$USER_ID,gid=$GROUP_ID,rw,suid,dev,exec,auto,nofail,nouser,async 0 0" | sudo tee -a /etc/fstab
echo "//$WINDOWS_IP/GShare /mnt/programs cifs credentials=$SMB_CREDENTIALS,iocharset=utf8,vers=3.0,uid=$USER_ID,gid=$GROUP_ID,rw,suid,dev,exec,auto,nofail,nouser,async 0 0" | sudo tee -a /etc/fstab
echo "//$WINDOWS_IP/ZShare /mnt/media cifs credentials=$SMB_CREDENTIALS,iocharset=utf8,vers=3.0,uid=$USER_ID,gid=$GROUP_ID,rw,suid,dev,exec,auto,nofail,nouser,async 0 0" | sudo tee -a /etc/fstab

# Mount all filesystems
sudo mount -a

echo "Mount points created and /etc/fstab updated."
