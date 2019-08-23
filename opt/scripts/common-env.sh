!#/usr/bin/sh

## kerberos
export KRB5_CONFIG=/path/to/krb5.conf

## kafka
export KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/client-jaas.conf -Djava.security.krb5.conf=/path/to/krb5.conf -Dsun.security.krb5.debug=false"
export SCHEMA_REGISTRY_OPTS="-Djava.security.auth.login.config=/path/to/client-jaas.conf -Djava.security.krb5.conf=/path/to/krb5.conf -Dsun.security.krb5.debug=false"

## custom java/binaries
export JAVA_HOME=/path/to/java
export PATH=$PATH:$JAVA_HOME/bin
