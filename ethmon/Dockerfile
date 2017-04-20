FROM ubuntu:16.04
MAINTAINER Samuel Cozannet <samuel.cozannet@madeden.com>

RUN apt update \
  && apt upgrade -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
  && apt install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
      apt-transport-https \
      curl \
      wget \
      ca-certificates \
      git \
      libicu-dev \
      lsb-release \
      rlwrap \
      imagemagick \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NODE_VERSION=6.10.2

RUN curl https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/nodejs_${NODE_VERSION}-1nodesource1~xenial1_amd64.deb > node.deb \
  && dpkg -i node.deb \
  && rm node.deb

WORKDIR /

RUN mkdir /config && \
    git clone https://github.com/osnwt/ethmon.git && \
    cd ethmon && \
    npm install && \
    ln -sf /config/config.json /ethmon/config.json

COPY config.json /config/config.json

WORKDIR /ethmon

ENTRYPOINT [ "npm", "start" ]
