FROM httpd:2.4

RUN apt-get update -y && \
    apt-get install libapache2-mod-auth-openidc libcjose0 -y && \
    rm -rf /var/lib/apt/lists/*