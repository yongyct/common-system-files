# Redis Helpful Tools

## Redis cluster mode shell
* `redis-cli -p myport -h myhost -a myauth -c`

## Starting individual redis instance
* `redis-server /path/to/redis.conf`

## Starting redis cluster (after starting individual nodes)
* `redis-cli --cluster create host1:port1 ... host6:port6 --cluster-replicas 1 -a mypassword`

## Some `redis-cli` commands
* `CLUSTER NODES`
* `CLUSTER INFO`

# Redis cluster node migration
1) Start new instances (both masters and slaves)
2) Add new masters to cluster: `redis-cli --cluster add-node [newmasterhost:port] [anycurrenthost:port] -a mypassword`
3) Reshard data to new master:
	1) Execute `redis-cli --cluster reshard [anycurrenthost:port] -a mypassword`
	2) Select desired number of slots for new node
	3) Select new node id as target node
	4) Select source node id from pool of current node to move the slots from, then select done
4) Add new slaves to cluster: `redis-cli --cluster add-node [newslavehost:port] [anycurrenthost:port] --cluster-slave --cluster-master-id [masternodeid] -a mypassword`
5) Remove old master & slave: `redis-cli --cluster del-node [anycurrenthost:port] [nodeidforremoval] -a mypassword`

# References
* https://redis.io/topics/cluster-tutorial
* Migrating cluster - https://dev.to/afilmycode/how-we-migrated-aws-elasticache-redis-cluster-to-another-in-production-297f
* Migrating standalone - https://medium.com/@elliotchance/migrating-data-between-redis-servers-without-downtime-429e4c8048e6
