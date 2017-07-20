from subprocess import check_output as cmd
from datetime import datetime
from sys import argv
import time
import os

hostname = os.uname()[1]
title = argv[1]
outputFile = title + '.txt'

result = open(outputFile, 'w')
timee = datetime.now().strftime('%H:%M:%S')
command = 'top -n 1 -b | head -n 12'

print >> result, '------ On Host ' + hostname + ' -------' 
print >> result, 'New Script to measure test: ' + title + 'starts at:  '  + timee

for i in range(1,20):	
	output = cmd(command, shell=True)
	print >> result,'--- Result at: %s' %(datetime.now().strftime('%H:%M:%S'))
	display = output.split("\n")	
	for line in display[5:-1]:
		print >> result, line
	time.sleep(5)

