FROM ubuntu:20.04
MAINTAINER iplon-india
COPY localtime /etc/
RUN apt update
COPY setup_18.sh /
RUN /bin/sh -c /setup_18.sh
RUN apt -y install git nodejs
RUN mkdir -p /var/log/nodeRed
RUN npm install -g --unsafe-perm node-red

RUN apt -y install software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev python3 python3-pip
RUN pip3 install influxdb-client pandas

COPY influx  /usr/sbin/
RUN chmod 755 /usr/sbin/influx

RUN npm -g install node-red-contrib-opcua
RUN npm -g install node-red-contrib-influxdb
RUN npm -g install node-red-contrib-modbus
RUN npm -g install node-red-contrib-cron-plus 
RUN npm -g install node-red-contrib-fs-ops 
RUN npm -g install node-red-contrib-tofloat
RUN npm -g install @meowwolf/node-red-contrib-amqp

COPY settings.js /root/.node-red/

CMD [ "node-red" ]

