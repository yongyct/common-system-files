# Kafka Commands
## Get last offset for partition
`bin/kafka-run-class kafka.tools.GetOffsetShell --topic mytopic --broker-list kafkahost1:port1,kafkahost2:port2 --partitions 0 --time -1`

## Datagen for testing
`bin/ksql-datagen schema=/path/to/avscfile format=delimited topic=mytopic key=myId bootstrap-server=kafkahost1:port1,kafkahost2:port2 schemaRegistryUrl=srurl:srport maxInterval=1`

## Get connectors
* default kafka connect port: 8083
* All connectors
  * `curl http://connecthost:connectport/connectors/`
* Specific connector
  * `curl http://connecthost:connectport/connectors/connector-name/status`
  
## Get topics
* default REST Proxy port: 8082
* All topics
  * `curl http://resthost:restport/topics`
  
## Get schemas
* default schema registry port: 8081
* All schemas/subjects
  * `curl http://srhost:srport/subjects`
* Specific schema
  * `curl http://srhost:srport/subjects/subject-name/versions/latest`
