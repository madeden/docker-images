# Copyright 2016 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This Dockerfile will build an image that is configured
# to run Fluentd with an Elasticsearch plug-in and the
# provided configuration file.
# TODO(a-robinson): Use a lighter base image, e.g. some form of busybox.
# The image acts as an executable for the binary /usr/sbin/td-agent.
# Note that fluentd is run with root permssion to allow access to
# log files with root only access under /var/log/containers/*
# Please see http://docs.fluentd.org/articles/install-by-deb for more
# information about installing fluentd using deb package.

FROM ubuntu:16.04
MAINTAINER Alex Robinson "arob@google.com"
MAINTAINER Jimmi Dyson "jimmidyson@gmail.com"
MAINTAINER Samuel Cozannet <samuel.cozannet@madeden.com>

# Ensure there are enough file descriptors for running Fluentd.
RUN ulimit -n 65536

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

# Install prerequisites.
RUN apt update && \
    apt install -yqq  --allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends \
    	curl \
    	make \
    	g++ \
    	libsystemd0 \
    	libsystemd-dev \
    	sudo \
    	rubygems \
    	ruby-dev && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Fluentd.
RUN /usr/bin/curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | sh

# Change the default user and group to root.
# Needed to allow access to /var/log/docker/... files.
RUN sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent

# Install journald gem
RUN gem install systemd-journal && \
	gem cleanup 

# Install the Elasticsearch Fluentd plug-in.
RUN td-agent-gem install \
		fluent-plugin-kubernetes_metadata_filter \
		fluent-plugin-elasticsearch \
		fluent-plugin-systemd \
		fluent-plugin-aws-elasticsearch-service \
		fluent-plugin-s3 \
		fluent-plugin-kubernetes

# Plugin Documentation:
#  - https://github.com/fluent/fluent-plugin-s3
#  - https://github.com/atomita/fluent-plugin-aws-elasticsearch-service
#  - https://github.com/fabric8io/fluent-plugin-kubernetes
#  - https://github.com/fabric8io/fluent-plugin-kubernetes_metadata_filter
#  - 

# Copy the Fluentd configuration file.
# COPY td-agent.conf /etc/td-agent/td-agent.conf

# Run the Fluentd service.
ENTRYPOINT ["td-agent"]
