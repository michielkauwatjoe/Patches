# -*- coding: UTF-8 -*-
#
# Downloads all the image links at the supplied URL, and saves them to the
# specified output file ("/test/" by default)
#
# Usage:
#
# python scrape-images.py http://example.com/ [output]
#

from BeautifulSoup import BeautifulSoup as bs
import urlparse
from urllib2 import urlopen
from urllib import urlretrieve
import os
import sys

def main(url, out_folder="/test/"):
	u"""
	Downloads all the images at URL to /test/
	"""
	soup = bs(urlopen(url))
	#parsed = list(urlparse.urlparse(url))

	# first get all images.
	for a in soup.findAll('a', href=True):
		if '.JPG' in a['href']:
			url_highres = a['href']
			filename = url_highres.split('/')[-1]
			outpath = os.path.join(out_folder, filename)
			if url_highres.lower().startswith("http"):
				urlretrieve(url_highres, outpath)

	# Then find Older Posts link and do again.
	for a in soup.findAll('a', href=True):
		for c in a.contents:
			if c == u'Older Posts':
				newurl = a['href']
				newurl = newurl[:-1] + '1500'
				main(newurl, out_folder)
				break
		

def _usage():
	u"""
	"""
	print "usage: python dumpimages.py http://example.com [outpath]"

if __name__ == "__main__":
	u"""
	"""
	url = sys.argv[-1]
	out_folder = "/test/"

	if not url.lower().startswith("http"):
		out_folder = sys.argv[-1]
		url = sys.argv[-2]
		if not url.lower().startswith("http"):
			_usage()
			sys.exit(-1)

	main(url, out_folder)
