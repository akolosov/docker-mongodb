#!/bin/bash

if [ -n "$MONGODB_SINGLE_SERVER" ]; then
	echo "Starting up single MongoDB server"
  /usr/bin/mongod --config $MONGOD_CONFIG_FILE --dbpath $MONGODB_DATA_PATH --port $MONGODB_MAIN_PORT --notablescan --noprealloc --smallfiles $OPTIONS	 	
fi

if [ -n "$MONGODB_REPLICA_SET" ]; then
	echo "Starting up MongoDB replica set $MONGODB_REPLICA_SET"
	/usr/bin/mongod --config $MONGOD_CONFIG_FILE --dbpath $MONGODB_DATA_PATH --port $MONGODB_MAIN_PORT --notablescan --noprealloc --smallfiles --replSet $MONGODB_REPLICA_SET $OPTIONS
	sleep 3
	echo "Setting up MongoDB replica set $MONGODB_REPLICA_SET"
	cat /usr/local/etc/initiate.js|/usr/bin/mongo --host $HOSTNAME --port $MONGODB_MAIN_PORT
fi

if [ -n "$MONGODB_CONFIG_SET" ]; then
	echo "Starting up MongoDB config server $MONGODB_REPLICA_SET"
	/usr/bin/mongod --config $MONGOD_CFG_CONFIG_FILE --configsvr --dbpath $MONGODB_METADATA_PATH --port $MONGODB_CONFIG_PORT $OPTIONS	
fi

if [ -n "$MONGODB_ROUTER_SET" ]; then
	echo "Starting up MongoDB router $MONGODB_REPLICA_SET"
	/usr/bin/mongos --config $MONGOS_CONFIG_FILE --configdb $MONGODB_CONFIG_SERVERS --port $MONGODB_ROUTER_PORT $OPTIONS
fi
