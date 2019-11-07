FROM ubuntu:18.04
ARG RPKICLIENT_VER=archive/VERSION_0_2_0.tar.gz
ARG TINI_VER=0.18.0

# Use tini to ensure fort can be CTRL-C stopped when running as a Docker container
ADD https://github.com/krallin/tini/releases/download/v${TINI_VER}/tini /tini
RUN chmod +x /tini

# Install supporting tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        curl \
        libssl-dev \
        libssl1.1 \
        pkg-config \
        rsync \
        wget

# Install rpki-client
WORKDIR /tmp/build/rpki-client
RUN curl -fsSLo- https://github.com/kristapsdz/rpki-client/${RPKICLIENT_VER} | tar zx --strip-components 1 && \
    sed -i -e 's|^#\([A-Z]\+\)|\1|' Makefile && \
    mkdir /usr/local/lib/eopenssl && \
    cd /usr/local/lib/eopenssl && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.a && \
    ln -s /usr/lib/x86_64-linux-gnu/libcrypto.a && \
    cd /tmp/build/rpki-client && \
    ./configure && make && make install

# Cleanup
RUN rm -Rf /tmp/build && \
    apt-get purge -y --auto-remove \
        build-essential \
        curl \
        libssl-dev \
        pkg-config \
        wget && \
    apt-get clean

# Create required directories
RUN mkdir -p /tals /var/cache/rpki-client

# Download the freely available TAL files (excludes ARIN).
ADD https://raw.githubusercontent.com/kristapsdz/rpki-client/master/tals/afrinic.tal /tals/
ADD https://raw.githubusercontent.com/kristapsdz/rpki-client/master/tals/apnic.tal /tals/
ADD https://raw.githubusercontent.com/kristapsdz/rpki-client/master/tals/lacnic.tal /tals/
ADD https://raw.githubusercontent.com/kristapsdz/rpki-client/master/tals/ripe.tal /tals/

# Install our entrypoint helper script
COPY entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh

# Run rpki-client via Tini to ensure signals to PID 1 are respected
ENTRYPOINT ["/tini", "-g", "--", "/opt/entrypoint.sh"]
CMD ["-e", "/usr/bin/rsync", "/tals/*.tal"]
