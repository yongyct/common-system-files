!#/usr/bin/sh

# Default zk port = 2181, broker port = 9092

# KAFKA_OPTS to be set
## Consumer
/path/to/kafka-console-consumer --consumer.config /path/to/client.properties --topic mytopic --bootstrap-server kafkahost1:port1,kafkahost2:port2 --property print.timestamp=true

## Producer
/path/to/kafka-console-producer --producer.config /path/to/client.properties --topic mytopic --broker-list kafkahost1:port1,kafkahost2:port2

# SCHEMA_REGISTRY_OPTS to be set
## Avro Consumer
/path/to/kafka-avro-console-consumer --consumer.config /path/to/client.properties --topic mytopic --bootstrap-server kafkahost1:port1,kafkahost2:port2 --property print.timestamp=true --property schema.registry.url=host:port --from-beginning

## Create topics
./kafka-topics --create --zookeeper zkhost:zkport --partitions 1 --replication-factor 1 --config retention.ms=240000 --topic mytopic
