# Derived from https://github.com/graphsense/graphsense-blocksci/blob/master/Dockerfile

# Default to a known, good commit
ARG BLOCKSCI_BASE=49db5f49ec640e68c912547d756ecab2b1537208

FROM ubuntu:18.04 as builder

ARG BLOCKSCI_BASE

RUN apt-get update && \
    # install packages
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
            autoconf \
            automake \
            build-essential \
            ca-certificates \
            cmake \
            git \
            libboost-all-dev \
            liblz4-dev \
            libtool \
            libjsoncpp-dev \
            libjsonrpccpp-client0 \
            libjsonrpccpp-common0 \
            libjsonrpccpp-dev \
            libjsonrpccpp-tools \
            libpython3-dev \
            libsparsehash-dev \
            libssl-dev \
            python3.6 \
            python3-crypto \
            python3-pip \
            python3-psutil \
            python3-setuptools \
            python3-wheel \
            wget

RUN cd /opt && \
    git clone https://github.com/citp/BlockSci.git && \
    cd BlockSci && \
    git checkout ${BLOCKSCI_BASE} && \
    git submodule init && \
    git submodule update --recursive && \
    mkdir release && \
    cd release && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    make install && \
    cd /opt/BlockSci && \
    # python
    pip3 install requests==2.23.0

#    pip3 install cassandra-driver==3.16.0 && \
RUN    cd /opt/BlockSci && pip3 install -e blockscipy

    # clean up
RUN cd / && \
    mv /opt/BlockSci/blockscipy /opt/ && \
    rm -rf /opt/BlockSci/* && \
    mv /opt/blockscipy /opt/BlockSci

FROM ubuntu:18.04

COPY --from=builder /opt/BlockSci/blockscipy/blocksci /usr/local/lib/python3.6/dist-packages/blocksci
COPY --from=builder /usr/bin/blocksci_* /usr/local/bin/
COPY --from=builder /usr/lib/x86_64-linux-gnu/libblocksci.so /usr/local/lib/
COPY --from=builder /usr/local/lib/python3.6/dist-packages /usr/local/lib/python3.6/dist-packages

RUN apt-get update && \
    # install packages
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ipython3 \
        libjsoncpp1 \
        libjsonrpccpp-client0 \
        libssl1.1 \
        neovim \
        python3-crypto \
        python3-pandas \
        python3-pip \
        python3-psutil && \
    mkdir -p /var/data/blocksci_data && \
    mkdir -p /var/data/block_data


