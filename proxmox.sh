#!/bin/bash
 
IPESCOLHA=$(ip a | grep inet | awk -F '  +' '{print $2}'| cut -d" " -f2 | sed -e "s/^/IP: /g" | cut -d/ -f1 | head -2 | cut -d ':' -f 2 | tail -n 1 | sed -e "s/ //g")

clear

cat << EOF
██████╗ ██████╗  ██████╗ ██╗  ██╗███╗   ███╗ ██████╗ ██╗  ██╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗
██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝████╗ ████║██╔═══██╗╚██╗██╔╝    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║
██████╔╝██████╔╝██║   ██║ ╚███╔╝ ██╔████╔██║██║   ██║ ╚███╔╝     ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║
██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗ ██║╚██╔╝██║██║   ██║ ██╔██╗     ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║
██║     ██║  ██║╚██████╔╝██╔╝ ██╗██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
EOF
echo "+------------------------------------------+"
printf "| %-40s |\n" "`date`"
echo "|                                          |"
printf "|`tput bold` %-40s `tput sgr0`|\n" "- Rafael Borges"
printf "|`tput bold` %-40s `tput sgr0`|\n" "- github.com/RafaelB13"
echo "+------------------------------------------+"
echo
echo
echo "-------------------> CONFIGURAÇÃO INICIAL <-----------------------"
echo "IPs DO SERVIDOR:"
sleep 1
echo
ip a | grep inet | awk -F '  +' '{print $2}'| cut -d" " -f2 | sed -e "s/^/IP: /g" | cut -d/ -f1
echo
sleep 1
read -p "Configuração de IP => (Aperte [ENTER] para escolher o IP: $(ip a | grep inet | awk -F '  +' '{print $2}'| cut -d" " -f2 | sed -e "s/^/IP: /g" | cut -d/ -f1 | head -2 | cut -d ':' -f 2 | tail -n 1 | sed -e "s/ //g")) ou digite um IP diferente: " ip
while [ -z "$ip" ]; do

if [ -z "$ip" ]
then
	while [ -z "$ip" ]; do
    	read -p "Deseja utilizar o IP $IPESCOLHA?  (y/n): " yn
    	case $yn in
        	[Yy]* ) ip=$IPESCOLHA; break;;
        	[Nn]* ) 
			while [ -z "$ip" ]; do
				if [ -z "$ip" ] 
				then		
					echo "INSIRA UM ENDEREÇO DE IP!";
					read -p "Insira o IP (Sem máscara): " ip;
				fi
			done
			;;
        	* ) echo "Escolha uma opção correta!";;
    	esac
done
	
else
      echo "ENDEREÇO IP: $ip"
fi
done

echo
echo

read -p "Insira o hostname: (ex: server-01.ne1.absam.network) " hostname
if [ -z "$hostname" ]
then
while [ -z "$hostname" ]; do

	echo "INSIRA UM HOSTNAME!"
	read -p "Insira o hostname: (ex: server-01.ne1.absam.network) " hostname
done
else
	echo $hostname > /etc/hostname
	hostname $hostname
fi

cat <<EOF >/etc/hosts
# Your system has configured 'manage_etc_hosts' as True.
# As a result, if you wish for changes to this file to persist
# then you will need to either
# a.) make changes to the master file in /etc/cloud/templates/hosts.debian.tmpl
# b.) change or remove the value of 'manage_etc_hosts' in
#     /etc/cloud/cloud.cfg or cloud-config from user-data
#
127.0.0.1	localhost
$ip	$hostname	$(echo $hostname | cut -d. -f1)

# The following lines are desirable for IPv6 capable hosts
::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

echo
echo

echo "####### INSTALL PROXMOX ###########"
echo
sleep 2
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
sleep 2
