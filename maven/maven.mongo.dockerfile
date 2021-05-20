FROM maven:3.6.3-adoptopenjdk-11-openj9

ARG MONGO_VERSION=4.4.3
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install ca-certificates curl gnupg -y

RUN MONGO_MAJOR_MINOR_VERSION=`echo $MONGO_VERSION | cut -d '.' -f 1,2` && \
    curl -sL https://www.mongodb.org/static/pgp/server-${MONGO_MAJOR_MINOR_VERSION}.asc | apt-key add - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${MONGO_MAJOR_MINOR_VERSION} multiverse" > /etc/apt/sources.list.d/mongodb-org-${MONGO_MAJOR_MINOR_VERSION}.list && \
    apt-get update -y

RUN apt-get install mongodb-org-server=${MONGO_VERSION} git gcc g++ make -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mongodb