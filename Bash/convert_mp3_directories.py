#!/usr/bin/env python

import os
from os.path import exists
import shutil
path = '/home/michiel/Music/'
delimiter = ' - '

artists = os.listdir(path)

for artist in artists:
	artistpath = path + '/' + artist

	albums = os.listdir(artistpath)
	for album in albums:
		list = album.split(delimiter)
		year = list[0]
		if len(year) != 4:
			break
		try:
			year = int(year)
			print year
		except:
			break

		albumpath = artistpath + '/' + album
		if year > 1000 and year < 9999:
			
			oldpath = albumpath
			newpath = artistpath + '/' + delimiter.join(list[1:])
			if exists(newpath):
				print newpath + ' exists!'
			else:
				shutil.move(oldpath, newpath)
				print 'moved %s to %s.' % (oldpath, newpath)
