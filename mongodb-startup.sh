#!/bin/sh

if [ -n $SINGLE_SERVER ]; then
  /usr/bin/mongod --config $MONGODB_CONFIG_FILE --dbpath $MONGODB_DATA_PATH --port $MONGODB_MAIN_PORT --notablescan --noprealloc $SINGLE_SERVER_OPTIONS	 	
fi

if [ -n $REPLICA_SET ]; then
  /usr/bin/mongod --config $MONGODB_CONFIG_FILE --replSet $REPLICA_SET --dbpath $MONGODB_DATA_PATH --port $MONGODB_MAIN_PORT --notablescan --noprealloc $REPLICA_SET_OPTIONS	 	
fi

if [ -n $CONFIG_SET ]; then
	/usr/bin/mongod --config $MONGODB_CONFIG_FILE --configsvr --dbpath $MONGODB_METADATA_PATH --port $MONGODB_CONFIG_PORT $CONFIG_SET_OPTIONS	
fi

if [ -n $ROUTER_SET ]; then
	/usr/bin/mongos --config $MONGODB_CONFIG_FILE --configdb $MONGODB_CONFIG_SERVERS --port $MONGODB_ROUTER_PORT $ROUTER_SET_OPTIONS
fi
