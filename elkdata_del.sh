#!/bin/bash

curl -XGET http://172.16.10.66:9200/_cat/indices > /export/elk/elkindex.txt 2>/dev/null

DATA=`date --date='10 days ago' +%Y.%m.%d`

INDEX=`awk '{print $3}' /root/elkindex.txt`

for i in $INDEX
	do
		if [[ $i =~ $DATA ]]; then
			echo $i 'was deleted' >> /export/elk/elk_del_data.log 2>/dev/null
			curl -XDELETE http://172.16.10.66:9200/$i >/dev/null 2>&1
		fi
	done

