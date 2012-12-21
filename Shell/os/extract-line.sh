#!/bin/bash

for i in *.rdf
do
#echo $i

	x=`echo "$i"|sed -e 's/.rdf/.html/'`
	y=`grep "<caption>" "$i"`
	open="<html><body>"
	close="</body></html>"
	echo $open$y$close > $x


done
