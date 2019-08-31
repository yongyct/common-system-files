#!/usr/bin/sh

## Reference from https://medium.com/@elliotchance/migrating-data-between-redis-servers-without-downtime-429e4c8048e6

OLD="redis-cli -h myoldhost -p myoldport -a mypassword"
NEW="redis-cli -h mynewhost -p mynewport -a mypassword"

## Assuming /tmp has enough space for temporarily storing all the old redis data
for KEY in $($OLD --scan); do
    $OLD --raw DUMP "$KEY" | head -c-1 > /tmp/dump
    TTL=$($OLD --raw TTL "$KEY")
    case $TTL in
        -2)
            $NEW DEL "$KEY"
            ;;
        -1)
            $NEW DEL "$KEY"
            cat /tmp/dump | $NEW -x RESTORE "$KEY" 0
            ;;
        *)
            $NEW DEL "$KEY"
            cat /tmp/dump | $NEW -x RESTORE "$KEY" "$TTL"
            ;;
    esac
    echo "$KEY (TTL = $TTL)"
done