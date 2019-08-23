# Using redis==2.10.6, redis-py-cluster==1.3.6

import redis
import rediscluster

# Standalone connection pool and session creation
standalone_connection_pool = redis.ConnectionPool(
    host=myhost,
    port=myportint,
    password=mypassword,
    db=0,
    socket_keepalive=True,
    socket_connect_timeout=120,
    socket_timeout=120,
    retry_on_timeout=True
)
standalone_session = redis.StrictRedis(
    connection_pool=standalone_connection_pool
)

# Cluster connection pool and session creation
cluster_connection_pool = rediscluster.connection.ClusterConnectionPool(
    startup_nodes=[{'host':'myhost', 'port':'myportstr'}],
    password=mypassword,
    db=0,
    socket_keepalive=True,
    socket_connect_timeout=120,
    socket_timeout=120,
    retry_on_timeout=True
)
cluster_session = rediscluster.StrictRedisCluster(
    connection_pool=cluster_connection_pool,
    decode_responses=True
)

# Using standalone/cluster session
for key in standalone_session.scan(match='*keypattern*', count=10000):
    print(standalone_session.get(key))
    
for key in cluster_session.scan(match='*keypattern*', count=10000):
    print(cluster_session.get(key))
