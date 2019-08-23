!#/usr/bin/sh

# KAFKA_OPTS to be set
## Consumer
/path/to/kafka-console-consumer --consumer.config /path/to/client.properties --topic mytopic --bootstrap-server kafkahost1:port1,kafkahost2:port2 --property print.timestamp=true

## Producer
/path/to/kafka-console-producer --producer.config /path/to/client.properties --topic mytopic --broker-list kafkahost1:port1,kafkahost2:port2

# SCHEMA_REGISTRY_OPTS to be set
## Avro Consumer
/path/to/kafka-avro-console-consumer --consumer.config /path/to/client.properties --topic mytopic --bootstrap-server kafkahost1:port1,kafkahost2:port2 --property print.timestamp=true --property schema.registry.url=host:port --from-beginning
