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
speed = [2,3,3,4]

for i in range(1,5):
        time = datetime.now().strftime('%H:%M:%S')
        testSpeed = speed[i-1]
        command = 'iperf3 -c %s -i 2 -O 2 -t 30s -b %sg %s' %(serverIP, testSpeed, trafficType)

        print >> result, 'Test #%d start at: %s' %(i,time)
        print >> result, cmd(command, shell=True)


