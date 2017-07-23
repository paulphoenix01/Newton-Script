# OpenStack Newton - Automation Scripts
## Intro 
This Repo contains scripts for automating the process of installing a fresh setup of OpenStack Newton, along with Arista EOS Switch as Layer 2 Layer 3 device.

## Topology
In order to use this script, it is required to have at least 2 nodes: 
- Controller Node
- Compute Node

Both nodes will be running Ubuntu Server 16.04.2 LTS 
Each node will have 2 NICs:
- Management interface: for internal communication between nodes
- Data interface: for VMs within OpenStack to communicate and access the Internet.

## Installation
### Prereq
- VMs must be on KVM and have nested virtualization enabled.
- User must define all NICs name, IP address, and credential in the config.cfg
> vim Newton-Script/config.conf

### Script Execution
For each node, you need to execute three script, which do the following:
```
setup01.sh : Install and Config OpenStack Prerequisites
setup02.sh : Install and Config OpenStack core components
setup03.sh : Install and Config Arista Driver for OpenStack Newton.
``` 

The steps are as follow

```
# Change directory to the script repo
cd Newton-Script
chmod -R +x *.sh
```
- On Controller
```
bash setup01.sh controller
bash setup02.sh controller
bash setup03.sh controller
```
- On Compute
```
bash setup01.sh compute1
bash setup02.sh compute1
bash setup03.sh compute1
```

The VMs will reboot after finish executing the script. 
