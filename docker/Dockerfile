FROM ubuntu:14.04

RUN apt-get update && apt-get install -y nfs-kernel-server
RUN mkdir -p /exports

VOLUME /exports

EXPOSE 111/udp 2049/tcp

ADD run.sh /usr/local/bin/run.sh
ENTRYPOINT ["run.sh"]
