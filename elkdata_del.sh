#!/bin/bash

curl -XGET http://localhost:9200/_cat/indices > elkindex.txt 2>/dev/null

DATA=`date --date='10 days ago' +%Y.%m.%d`

INDEX=`awk '{print $3}' /root/elkindex.txt`

for i in $INDEX
	do
		if [[ $i =~ $DATA ]]; then
			echo $i 'was deleted' >> elk_del_data.log 
			curl -XDELETE http://localhost:9200/$i >/dev/null 2>&1
		fi
	done

