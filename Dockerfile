FROM dobor/alpine-base:latest

LABEL MAINTAINER=chobon@aliyun.com

ENV ARIA2_VERSION=1.35.0

ADD https://github.com/q3aql/aria2-static-builds/releases/download/v${ARIA2_VERSION}/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1.tar.bz2 /tmp/

RUN tar -jxvf /tmp/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1.tar.bz2 && \
    cp /tmp/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1/aria2c /usr/bin/aria2c && \
    rm -rf /tmp/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1* && \
    chmod a+x /usr/bin/aria2c

# copy local files
ADD root /

# file downloading folder
VOLUME /config /downloads

EXPOSE 6800  6881  6881/udp