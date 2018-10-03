#!/usr/bin/python3.6

import csv
csv_file = open("../train_flat.csv")

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

