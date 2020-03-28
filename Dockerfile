FROM dobor/alpine-base:latest

LABEL MAINTAINER=chobon@aliyun.com

ENV ARIA2_VERSION=1.35.0 \
    UpdateTracker=true \
    SECRET=yourtoken \
    CACHE=512M \
    QUIET=true

RUN apk --update --no-progress --no-cache add curl && \
    curl -sSL https://github.com/q3aql/aria2-static-builds/releases/download/v${ARIA2_VERSION}/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1.tar.bz2 \
    | tar jxvf - -C /tmp/ && \
    cp /tmp/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1/aria2c /usr/bin/aria2c && \
    rm -rf /tmp/aria2-${ARIA2_VERSION}-linux-gnu-64bit-build1* && \
    apk del curl && \
    rm -rf /var/cache/apk/*
    
RUN addgroup aria2 && \
    adduser -D -g "" -s /bin/sh -G aria2 aria2 && \
    chmod a+x /usr/bin/aria2c

# copy local files
ADD root /

# file downloading folder
VOLUME /config /downloads

EXPOSE 6800  6881  6881/udp