#!/bin/python

import os

from boto.s3.connection import S3Connection
from boto.s3.key import Key


BACKUPDIR = 'backups'
KEYPATH = 'keypair.txt'

def getKey(path):
	f = open(path, 'r')
	l = f.readline().strip()
	splits = l.split(', ')
	id = splits[0]
	key = splits[1]
	return id, key

def main():
	id, key = getKey(KEYPATH)
	conn = S3Connection(id, key)
	bucket = conn.get_bucket('aws.petr.com')
	k = Key(bucket)
	list = os.listdir(BACKUPDIR)
	for l in list:
		sublist = l.split('-')
		s3 = BACKUPDIR + '/' + sublist[2] + '/' + sublist[3] + '/' + sublist[4] + '/' + l
		p = BACKUPDIR + '/' + l
		k.key = s3
		k.set_contents_from_filename(p)
		os.remove(p)


if __name__ == "__main__":
	main()
