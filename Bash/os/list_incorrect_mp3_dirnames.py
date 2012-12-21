#!/usr/bin/env python

import os
import re
path = '/mnt/external/archive/music/official releases'

files = os.listdir(path)

p = re.compile('/d/d/d/d')
i = 0

for root, dirs, files in os.walk(path):

	for dir in dirs:

		list = dir.split(', ')
		year = list[-1]
		try:
			year = int(year)
			if year < 1000 or year > 9999:
				break
			else:
				i += 1
		except:
			break

		dirname = ', '.join(list[0:-1])

		if i > 100000000:
			break
		else:
			dirname = dirname.split(' (')
			print dirname[0]


	'''
	if filename.split('.')[1] == 'htmlpart':
	 	name = filename.split('.')[0]
		f = open(filename, mode='r')
		lines = f.readlines()
		f.close()

		f = open(filename, mode='w')

		index = 0
		for line in lines:
			f.write(line)
			if index == 1:
				f.write('<p>\n')
				f.write('<img src="img/cursussen/')
				f.write(name)
				f.write('.jpg" alt=" " title="" height="200" />\n')
				f.write('</p>\n\n\n')
			index += 1
	'''
