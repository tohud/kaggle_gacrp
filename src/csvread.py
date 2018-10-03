#!/usr/bin/python3.6
import csv
import os
GACRP_HOME=os.environ['GACRP_HOME']
csv_file = open(GACRP_HOME+"/dat/train_flat.csv")

f = csv.reader(csv_file,delimiter=",",doublequote=True)

i=0
datas = []
for row in f:
	if i%1000 ==0:
		print(i)
	i=i+1
	datas.append(row)

print(i-1)
print(datas[i-1])

