#!/bin/bash

echo "####### INSTALL PROXMOX ###########"
echo
echo
echo "Add the Proxmox VE repository:"
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

echo "# Add the Proxmox VE repository key as root"
sleep 2
wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg


echo "Update your repository and system by running:"
sleep 3
apt update && apt full-upgrade -y

echo "Install the Proxmox VE packages"
sleep 2
apt install proxmox-ve postfix open-iscsi -y

echo "############# END ###############"
