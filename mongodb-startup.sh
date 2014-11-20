#!/bin/sh

if [ -n $MONGODB_SINGLE_SERVER ]; then
  /usr/bin/mongod --config $MONGOD_CONFIG_FILE --dbpath $MONGODB_DATA_PATH --port $MONGODB_MAIN_PORT --notablescan --noprealloc --smallfiles $SINGLE_SERVER_OPTIONS	 	
fi

if [ -n $MONGODB_REPLICA_SET ]; then
  /usr/bin/mongod --config $MONGOD_CONFIG_FILE --replSet $MONGODB_REPLICA_SET --dbpath $MONGODB_DATA_PATH --port $MONGODB_MAIN_PORT --notablescan --noprealloc --smallfiles $REPLICA_SET_OPTIONS	 	
fi

if [ -n $MONGODB_CONFIG_SET ]; then
	/usr/bin/mongod --config $MONGOD_CFG_CONFIG_FILE --configsvr --dbpath $MONGODB_METADATA_PATH --port $MONGODB_CONFIG_PORT $CONFIG_SET_OPTIONS	
fi

if [ -n $MONGODB_ROUTER_SET ]; then
	/usr/bin/mongos --config $MONGOS_CONFIG_FILE --configdb $MONGODB_CONFIG_SERVERS --port $MONGODB_ROUTER_PORT $ROUTER_SET_OPTIONS
fi
