!#/usr/bin/sh

## kafka
export KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/client-jaas.conf -Djava.security.krb5.conf=/path/to/krb5.conf -Dsun.security.krb5.debug=false"
export SCHEMA_REGISTRY_OPTS="-Djava.security.auth.login.config=/path/to/client-jaas.conf -Djava.security.krb5.conf=/path/to/krb5.conf -Dsun.security.krb5.debug=false"
