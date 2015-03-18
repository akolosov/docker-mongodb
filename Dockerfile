FROM akolosov/ubuntu

# Add 10gen official apt source to the sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Install MongoDB
RUN apt-get update
RUN apt-get upgrade -yqq
RUN apt-get -yqq install mongodb-org psmisc
RUN apt-get -yqq clean
RUN rm -rf /var/lib/apt/lists/*

# Define mount points.
VOLUME ["/data/db", "/data/logs", "/data/meta"]

# Define working directory.
WORKDIR /data

RUN mkdir -p /data/db
RUN mkdir -p /data/meta
RUN mkdir -p /data/logs

ENV MONGODB_DATA_PATH /data/db
ENV MONGODB_METADATA_PATH /data/meta
ENV MONGODB_LOGS_PATH /data/logs
ENV MONGODB_MAIN_PORT 27017
ENV MONGODB_ROUTER_PORT 27018
ENV MONGODB_CONFIG_PORT 27019
ENV MONGOD_CONFIG_FILE /usr/local/etc/mongod.cfg
ENV MONGOD_CFG_CONFIG_FILE /usr/local/etc/mongod-cfg.cfg
ENV MONGOS_CONFIG_FILE /usr/local/etc/mongos.cfg

ADD mongodb-startup.sh /usr/local/sbin/mongodb-startup.sh
ADD mongod.cfg /usr/local/etc/mongod.cfg
ADD mongod-cfg.cfg /usr/local/etc/mongod-cfg.cfg
ADD mongos.cfg /usr/local/etc/mongos.cfg
RUN chmod 755 /usr/local/sbin/mongodb-startup.sh

CMD /usr/local/sbin/mongodb-startup.sh

EXPOSE 27017 27018 27019 28017
