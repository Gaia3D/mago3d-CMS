FROM postgis/postgis:12-master

COPY .vimrc /root/.vimrc
COPY bashrc /color-config

ENV TZ=Asia/Seoul
ENV POSTGRES_DB=mago3d
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_INITDB_ARGS="--encoding=UTF-8"
ENV ALLOW_IP_RANGE=0.0.0.0/0

RUN \
    apt-get update && \
    apt-get install -y vim && \
    cat color-config >> /etc/bash.bashrc




