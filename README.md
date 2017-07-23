# OpenStack Newton - Automation Scripts
## Intro 
This Repo contains scripts for automating the process of installing a fresh setup of OpenStack Newton, along with Arista EOS Switch as Layer 2 Layer 3 device. Also include several simple scripts that use "iperf3" and "top" tools in Ubuntu to test Speed and CPU.

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
* Note: All variables are explained in the config.cfg file.

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


## Test Script 

The script for testing network speed and CPU performance also include in the repo. Include 5 python scripts, which will be execute on the Client. The server must listening with the dedicated tools.
- iperf3 script for testing maximum speed. 
```
python iperf3-test.py $1 $2 $3

Example: python iperf3-test.py 192.168.100.1 1 output.txt
  - $1: Destination IP address
  - $2: Traffic Type. 1 = TCP traffic, 2 = UDP Traffic
  - $3: Output text file
```
- nuttcp script for testing maximum speed
```
python nuttcp-test.py $1 $2 $3

Example: python nuttcp-test.py 192.168.100.1 1 output.txt
  - $1: Destination IP address
  - $2: Traffic Type. 1 = TCP traffic, 2 = UDP Traffic
  - $3: Output text file
```
- qos-flood script and qos-script: For QoS testing. QoS-script will flood with speed patterns which defined in the script, and qos-flood will flood the maximum speed of the tools.
```
python qos-flood.py $1 $2 $3
python qos-script.py $1 $2 $3

Example: python qos-flood.py 192.168.100.1 1 output.txt
  - $1: Destination IP address
  - $2: Traffic Type. 1 = TCP traffic, 2 = UDP Traffic
  - $3: Output text file
```
- cpu-monitor script will use Ubuntu tool "top" to measure CPU statistic in 2 minute and output to a log file with timestamp.
```
python cpu-monitor.py $1

Example cpu-monitor.py compute-node
  - $1: hostname or test-name
```

