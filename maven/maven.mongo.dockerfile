FROM maven:3.6.3-adoptopenjdk-11-openj9

ARG MONGO_VERSION=4.4.3
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install ca-certificates curl gnupg -y

RUN curl -sL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update -y

RUN apt-get install mongodb-org-server=${MONGO_VERSION} gcc g++ make -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mongodb