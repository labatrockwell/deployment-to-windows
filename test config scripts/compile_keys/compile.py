#!/usr/bin/env python
with open("machine_names.txt") as f:
	content = f.readlines()

machine_id = 0
index_id = 1
name_id=2
ip_id=3
key_id=4

def add_to(list, item):
	arrItem = item.split(",")
	startIndex = arrItem[index_id]
	for entry in list:
		arrEntry = entry.split(",")
		if arrEntry[name_id] == arrItem[name_id]:
			if arrEntry[machine_id] != arrItem[machine_id]:
				println("matching name but not machine id?")
			else:
				continue
		if arrEntry[machine_id] == arrItem[machine_id]:
			println("warning: collision!")
			if arrEntry[index_id] >= arrItem[index_id]:
				arrItem[index_id] = arrEntry[index_id] + 1
	if arrItem[index_id] != startIndex:
		println("update " + arrItem[name_id] +" to index " + arrItem[index_id])
	list.append(item)


with open("machine_names.txt") as f:
	toAdd = f.readlines()

for line in toAdd:
	add_to(content, line)

with open("machine_name_3.txt") as f:
	toAdd = f.readlines()

for line in toAdd:
	add_to(content, line)

with open("compiled.txt", "w+") as f:
	for item in content:
		print>>f, item
