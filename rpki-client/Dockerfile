FROM debian:9
ARG RPKICLIENT_VER=6.7p1
ARG TINI_VER=0.18.0

# Use tini to ensure fort can be CTRL-C stopped when running as a Docker container
ADD https://github.com/krallin/tini/releases/download/v${TINI_VER}/tini /tini
RUN chmod +x /tini

# Install supporting tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        autoconf \
        build-essential \
        curl \
        git \
        libssl-dev \
        libtool \
        rsync \
        wget

# Install rpki-client
WORKDIR /tmp/build/rpki-client
RUN curl -fsSLo- https://github.com/rpki-client/rpki-client-portable/archive/${RPKICLIENT_VER}.tar.gz | tar zx --strip-components 1 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# Cleanup
RUN rm -Rf /tmp/build && \
    apt-get purge -y --auto-remove \
        build-essential \
        curl \
        libssl-dev && \
    apt-get clean

# Create required user & directories
RUN useradd _rpki-client
RUN mkdir -p /tals /usr/local/var/cache/rpki-client && \
    chown _rpki-client. /tals /usr/local/var/cache/rpki-client

# Install our entrypoint helper script
COPY entrypoint.sh /opt/
RUN chmod a+x /opt/entrypoint.sh

# Record the version of rpki-client as there doesn't appear to be any way to get it from rpki-client itself
RUN echo ${RPKICLIENT_VER} > /opt/version.txt

# Run rpki-client via Tini to ensure signals to PID 1 are respected
USER _rpki-client
ENTRYPOINT ["/tini", "-g", "--", "/opt/entrypoint.sh"]
CMD ["-e", "/usr/bin/rsync", "/tals/*.tal"]
