FROM alpine AS builder
ARG VER=3.1-2020.07.06.14.28
RUN apk add bash maven openjdk8
WORKDIR /tmp/
RUN wget https://github.com/RIPE-NCC/rpki-validator-3/archive/${VER}.tar.gz && \
    tar xvf ${VER}.tar.gz && \
    cd rpki-validator-3-${VER}/rpki-rtr-server && \
    mvn package -DskipTests || true
RUN cp /tmp/rpki-validator-3-${VER}/rpki-rtr-server/target/*.jar /tmp/rpki-rtr-server.jar

FROM ripencc/rpki-validator-3-docker:alpine
ARG VER=3.1-2020.07.06.14.28
RUN apk add bash
COPY --from=builder /tmp/rpki-rtr-server.jar /opt/rpki-rtr-server.jar
COPY --from=relyingpartybase /opt/* /opt/
COPY *.properties *.sh /opt/
ENV CONFIG_DIR=/opt/
RUN echo ${VER} > /opt/version.txt
ENTRYPOINT [ "/opt/entrypoint.sh" ]
