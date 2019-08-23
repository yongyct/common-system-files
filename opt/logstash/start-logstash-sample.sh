#!/usr/bin/sh

/path/to/bin/logstash -n "app instance name" -f /path/to/samplelog.conf --path.data=/path/to/data/folder --path.logs=/path/to/log/folder
