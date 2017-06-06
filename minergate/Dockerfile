FROM nvidia/cuda:8.0-devel

MAINTAINER Samuel Cozannet <samuel.cozannet@madeden.com>

ENV USERNAME=samnco@gmail.com
ENV COIN="-xmr"
ENV NB_CPU=1
ENV NB_GPU=0
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia:/usr/lib/cuda
ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && \
    apt-get install -y ca-certificates wget && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://minergate.com/download/deb-cli && \
    dpkg -i deb-cli && \
    rm -f deb-cli && \
    chmod +x /entrypoint.sh

CMD [ "/entrypoint.sh" ]