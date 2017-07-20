import sys
from datetime import datetime
from subprocess import check_output as cmd

# $1 = dest IP 
# $2 = Traffic Type: 1==TCP, 2==UDP
# $3 = outputFileName.txt
args = sys.argv

serverIP = args[1]
#1 = TCP, 2 = UDP
testType = args[2]
outputFile = args[3]

# TCP default
trafficType = ''
if testType == 2:
        trafficType = '-ub 10g'

result = open(outputFile, 'w')

for i in range(1,6):
        time = datetime.now().strftime('%H:%M:%S')
        command = 'iperf3 -c %s -p 5203 -i 2 -O 2 -b 5g -t 30s  %s' %(serverIP, trafficType)

        print >> result, 'Test #%d start at: %s' %(i,time)
        print >> result, cmd(command, shell=True)

