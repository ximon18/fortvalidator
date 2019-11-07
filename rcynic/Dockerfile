FROM ubuntu:18.04 AS builder
ARG RCYNIC_VER=buildbot-1.0.1544679302

# Install packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # rcynic dependencies
    build-essential \
    libpython2.7-dev \
    python2.7 \
    python-django \
    python-lxml \
    python-tornado \
    rrdtool \
    rsync \
    # Dockerfile dependencies
    curl  \
    git
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

# Build
WORKDIR /tmp/build/rpki
RUN git clone --branch ${RCYNIC_VER} --depth 1 https://github.com/dragonresearch/rpki.net.git .
RUN ./configure --disable-ca-tools && make && make install

# Cleanup
RUN rm -Rf /tmp/build && \
    apt-get purge -y --auto-remove \
        build-essential \
        curl \
        git \
        libpython2.7-dev \
        rrdtool && \
    apt-get clean

# Create required directories
RUN mkdir /tals /unauthenticated /out

# Install our config file and entrypoint helper script
COPY rcynic.conf /opt/rcynic.conf
COPY entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh

# Run Rcynic
ENTRYPOINT ["/opt/entrypoint.sh"]