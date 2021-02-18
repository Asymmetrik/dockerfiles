FROM ubuntu:bionic

ARG MONGO_VERSION=4.4.3

RUN apt-get update -y && \
    apt-get install ca-certificates curl gnupg -y

RUN curl -sL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update -y

RUN apt-get install mongodb-org-server=${MONGO_VERSION} nodejs gcc g++ make -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mongodb
