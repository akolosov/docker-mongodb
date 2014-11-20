FROM dockerfile/ubuntu

# Add 10gen official apt source to the sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Install MongoDB
RUN apt-get update
RUN apt-get install mongodb-10gen
RUN rm -rf /var/lib/apt/lists/*

# Define mount points.
VOLUME ["/data/db", "/data/meta", "/data/logs"]

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
ENV MONGODB_CONFIG_FILE /usr/local/etc/mongo.cfg

ADD mongodb-startup.sh /usr/local/sbin/mongodb-startup.sh
ADD mongo.cfg /usr/local/etc/mongo.cfg
RUN chmod 755 /usr/local/sbin/mongodb-startup.sh

CMD /usr/local/sbin/mongodb-startup.sh

EXPOSE 27017 27018 27019