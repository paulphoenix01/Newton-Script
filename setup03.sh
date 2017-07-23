#!/bin/bash


################
apt-get -y -f install
apt-get -y install lldpd
service lldpd restart

### Install Arista Driver for Controller
if [ "$1" == "controller" ]; then
	bash $dir_path/install/install_arista_controller.sh


## Install Arista Driver for compute1
elif ["$1" == "compute1" ]; then
	bash $dir_path/install/install_arista_compute.sh


else
	echo "Syntax Error"
	exit 1;

fi
