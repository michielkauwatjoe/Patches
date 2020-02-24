#!/usr/bin/python3
# -*- coding: UTF-8 -*-
import requests
import urllib.request
import time
from bs4 import BeautifulSoup

url = 'https://www.graffiti.org/jaz/index2.html'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
#print(soup)
areas = soup.findAll('area')

for area in areas:
    print(area['href'])

'''
l = link['href']

response = requests.get(url + l)
soup = BeautifulSoup(response.text, 'html.parser')
'''
