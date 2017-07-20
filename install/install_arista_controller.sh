#!/bin/bash


###
source $dir_path/../config.cfg
source $dir_path/../lib/functions.sh


lb_agent_ini=/etc/neutron/plugins/ml2/linuxbridge_agent.ini
metadata_agent_ini=/etc/neutron/metadata_agent.ini
dhcp_agent_ini=/etc/neutron/dhcp_agent.ini
ml2_conf_ini=/etc/neutron/plugins/ml2/ml2_conf.ini
neutron_conf=/etc/neutron/neutron.conf


apt-get update
apt-get install python-pip

git clone https://github.com/paulphoenix01/patched-arista; cd patched-arista; git checkout paul; pip install -r requirements.txt; python setup.py install;



ops_edit $ml2_conf_ini ml2 type_drivers flat,vlan
ops_edit $ml2_conf_ini ml2 tenant_network_types vlan
ops_edit $ml2_conf_ini ml2 mechanism_drivers linxbridge,l2population,arista
ops_edit $ml2_conf_ini ml2 extension_drivers port_security,qos
ops_edit $ml2_conf_ini ml2_type_vlan network_vlan_ranges provider:10:50
ops_edit $ml2_conf_ini ml2_arista eapi_host $CVX_ADDRESS
ops_edit $ml2_conf_ini ml2_arista eapi_username $CVX_USER
ops_edit $ml2_conf_ini ml2_arista eapi_password $CVX_PASSWORD
ops_edit $ml2_conf_ini l3_arista primary_l3_host $EOS_ADDRESS
ops_edit $ml2_conf_ini l3_arista primary_l3_host_username $EOS_USER
ops_edit $ml2_conf_ini l3_arista primary_l3_host_password $EOS_PASSWORD


ops_edit $lb_agent_ini linux_bridge physical_interface_mappings provider:$EXT_INTERFACE
ops_edit $lb_agent_ini agent extensions qos
ops_edit $lb_agent_ini securitygroup firewall_driver iptables
ops_edit $lb_agent_ini enable_vxlan True
ops_edit $lb_agent_ini local_ip $CTL_MGNT_IP
ops_edit $lb_agent_ini l2_population True

ops_edit $metadata_agent_ini DEFAULT nova_metadata_ip $metadata_agent_ini
ops_edit $metadata_agent_ini DEFAULT metadata_proxy_shared_secret $METADATA_SECRET

ops_edit $dhcp_agent_ini DEFAULT interface_driver linuxbridge
ops_edit $dhcp_agent_ini DEFAULT force_metadata True
ops_edit $dhcp_agent_ini DEFAULT enabled_isolated_metadata True

ops_edit $neutron_conf DEFAULT service_plugins arista_l3,neutron.services.qos.qos_plugin.QoSPlugin
ops_edit $neutron_conf DEFAULT dhcp_agents_per_network 2
ops_edit $neutron_conf keystone_authtoken auth_protocol https
ops_edit $neutron_conf keystone_authtoken auth_host $CTL_MGNT_IP
ops_edit $neutron_conf keystone_authtoken auth_port 35357

su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini --config-file /etc/neutron/plugins/ml2/ml2_conf_arista.ini upgrade heads" neutron

reboot

