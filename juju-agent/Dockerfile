FROM jujusolutions/jujubox:latest
# see https://hub.docker.com/r/jujusolutions/jujubox/ for more info

MAINTAINER Sistemas Internet <sistemasinternet@antena3tv.es>

ENV MODEL=default
ENV TARGET_DIR=/tmp/backup
ENV UNIT=0
ENV PREFIX=app
ENV APPLICATION=app

# This will perform an etcd backup operation 
ADD etcddump.sh /usr/bin/etcddump.sh
# This will backup /root/cdk from the master
ADD cdkdump.sh /usr/bin/cdkdump.sh
# This will backup the pki folder from easyrsa
ADD pkidump.sh /usr/bin/pkidump.sh
# This will backup an entire controller (mongodb + files). 
# See https://jujucharms.com/docs/stable/controllers-backup
ADD controllerdump.sh /usr/bin/controllerdump.sh
ADD controller-housekeeper.sh /usr/bin/controller-housekeeper.sh

WORKDIR /home/ubuntu

CMD [ "/usr/bin/entrypoint.sh" ]

