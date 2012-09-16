#!/usr/bin/env python

'''
 1. open files in current directory,
 2. select all the files with the 'htmlpart' extension,
 3. read all lines of all files,
 4. write back to same file but with some extra lines after the second line,
 5. second extra line contains a jpg image with te filename.
'''

import os

files = os.listdir('.')

for filename in files:

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
