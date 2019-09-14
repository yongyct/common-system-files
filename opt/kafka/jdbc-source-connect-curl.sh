#!/usr/bin/sh

# Reference blog post: https://www.confluent.io/blog/kafka-connect-deep-dive-jdbc-source-connector

# Create connectors 
curl -X POST https://connecthost:port/connectors -H "Content-Type: application/json" -d '{
    "name":"connector-name",
    "config":{
        #----connector specific configs, e.g. jdbc source---
        "connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url":"jdbc:dbtype://host:port/schema",
        "connection.user":"myuser",
        "connection.password":"mypassword",
        "table.whitelist":"mytable",
        "mode":"timestamp+incrementing",
        "incrementing.column.name":"id_col",
        "timestamp.column.name":"timestamp_col",
        "table.types":"VIEW",
        "validate.non.null":false,
        "topic.prefix":"myprefix-",
        "table.poll.interval.ms":"6000",
        "transforms":"dropSuffix",
        "transforms.dropSuffix.type":"org.apache.kafka.connect.transforms.RegexRouter",
        "transforms.dropSuffix.regex":"(.*)_view",
        "transforms.dropSuffix.replacement":"$1"
    }
}'

# Delete connector
curl -X DELETE https://connecthost:port/connectors/connector-name/

# Update connectors 
curl -X PUT https://connecthost:port/connectors/connector-name/config -H "Content-Type: application/json" -d '{
    #----connector specific configs, e.g. jdbc source---
    "connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector",
    "connection.url":"jdbc:dbtype://host:port/schema",
    "connection.user":"myuser",
    "connection.password":"mypassword",
    "table.whitelist":"mytable",
    "mode":"timestamp+incrementing",
    "incrementing.column.name":"id_col",
    "timestamp.column.name":"timestamp_col",
    "table.types":"VIEW",
    "validate.non.null":false,
    "topic.prefix":"myprefix-",
    "table.poll.interval.ms":"6000",
    "transforms":"dropSuffix",
    "transforms.dropSuffix.type":"org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.dropSuffix.regex":"(.*)_view",
    "transforms.dropSuffix.replacement":"$1"
}'
