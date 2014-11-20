FROM dockerfile/ubuntu

# Add 10gen official apt source to the sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Install MongoDB
RUN apt-get update
RUN apt-get upgrade -yqq
RUN apt-get -yqq install mongodb-org
RUN apt-get -yqq clean
RUN rm -rf /var/lib/apt/lists/*

# Define mount points.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

RUN mkdir -p /data/js
RUN mkdir -p /data/etc
RUN mkdir -p /data/db
RUN mkdir -p /data/meta
RUN mkdir -p /data/logs
RUN mkdir -p /data/bin


ENV MONGODB_DATA_PATH /data/db
ENV MONGODB_METADATA_PATH /data/meta
ENV MONGODB_LOGS_PATH /data/logs
ENV MONGODB_JS_PATH /data/js
ENV MONGODB_MAIN_PORT 27017
ENV MONGODB_ROUTER_PORT 27018
ENV MONGODB_CONFIG_PORT 27019
ENV MONGOD_CONFIG_FILE /data/etc/mongod.cfg
ENV MONGOD_CFG_CONFIG_FILE /data/etc/mongod-cfg.cfg
ENV MONGOS_CONFIG_FILE /data/etc/mongos.cfg

ADD js/initiate.js /data/js/initiate.js
ADD mongodb-startup.sh /data/bin/mongodb-startup.sh
ADD mongod.cfg /data/etc/mongod.cfg
ADD mongod-cfg.cfg /data/etc/mongod-cfg.cfg
ADD mongos.cfg /data/etc/mongos.cfg
RUN chmod 755 /data/bin/mongodb-startup.sh

CMD /data/bin/mongodb-startup.sh

EXPOSE 27017 27018 27019