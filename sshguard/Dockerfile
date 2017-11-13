FROM alpine:3.2
MAINTAINER samuel Cozannet <samuel.cozannet@madeden.com>
RUN apk add --update iptables ip6tables sshguard && rm -rf /var/cache/apk/*
ENTRYPOINT ["/usr/sbin/sshguard"]
