#!/bin/python
# Basic example script to read some database tables and dump them to JSON.

from pg import DB
from pprint import pprint
import json

def main():
    db = DB(dbname='databasename', host='127.0.0.1', port=5432, user='postgres', passwd='...')
    for tablename in ('table1', 'table2'):
        q = db.query('select * from %s where ...' % tablename)
        d = q.dictresult()
        json.dump(d, open("%s.txt" % tablename,'w'))


if __name__ == "__main__":
	main()
