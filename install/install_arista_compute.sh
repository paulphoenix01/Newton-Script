#!/bin/bash


###
source $dir_path/../config.cfg
source $dir_path/../lib/functions.sh


lb_agent_ini=/etc/neutron/plugins/ml2/linuxbridge_agent.ini
metadata_agent_ini=/etc/neutron/metadata_agent.ini
dhcp_agent_ini=/etc/neutron/dhcp_agent.ini



ops_edit $lb_agent_ini linux_bridge physical_interface_mappings provider:$EXT_INTERFACE
ops_edit $lb_agent_ini agent extensions qos
ops_edit $lb_agent_ini securitygroup firewall_driver iptables
ops_edit $lb_agent_ini enable_vxlan True
ops_edit $lb_agent_ini local_ip $COM1_MGNT_IP
ops_edit $lb_agent_ini l2_population True

ops_edit $metadata_agent_ini DEFAULT nova_metadata_ip $metadata_agent_ini
ops_edit $metadata_agent_ini DEFAULT metadata_proxy_shared_secret $METADATA_SECRET

ops_edit $dhcp_agent_ini DEFAULT interface_driver linuxbridge
ops_edit $dhcp_agent_ini DEFAULT force_metadata True
ops_edit $dhcp_agent_ini DEFAULT enabled_isolated_metadata True

reboot

