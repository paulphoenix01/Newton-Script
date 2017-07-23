#!/bin/bash


################
apt-get -f install
apt-get install lldpd
service lldpd restart

if [ "$1" == "controller" ]; then
	bash $dir_path/install/install_arista_controller.sh

elif ["$1" == "compute1" ]; then
	bash $dir_path/install/install_arista_compute.sh

else
	echo "Syntax Error"
	exit 1;

fi
