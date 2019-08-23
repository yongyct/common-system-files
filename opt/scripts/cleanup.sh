#!/usr/bin/sh

# to delete files older than 30 days
find [/path/to/files/] -name "*[filename pattern]*" -type f -mtime +30 | xargs rm -f

# to delete folders older than 30 days
find [/path/to/folders/] -name "*[folder pattern]*" -type d -mtime +30 | xargs rm -rf
