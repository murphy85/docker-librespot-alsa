FROM alpine:edge

WORKDIR /data

RUN apk -U add curl cargo portaudio-dev protobuf-dev
RUN cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/master.zip \
 && unzip master.zip \
 && rm -rf master.zip \
 && apk --purge del curl
RUN cd /root/librespot-master \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features --features "alsa-backend" \
 && mv /root/librespot-master/target/release/librespot /usr/local/bin
RUN apk --purge del cargo portaudio-dev protobuf-dev \
 && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/master.zip /root/librespot-master /root/.cargo
RUN apk add alsa-lib gcc llvm-libunwind

ENV SPOTIFY_NAME Docker
ENV SPOTIFY_DEVICE hw:0,0
ENV SPOTIFY_BITRATE 160
ENV SPOTIFY_INITIAL_VOLUME 75

CMD librespot -n "$SPOTIFY_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPOTIFY_DEVICE" -b "$SPOTIFY_BITRATE" --initial-volume "$SPOTIFY_INITIAL_VOLUME" --backend alsa --enable-volume-normalisation -c /tmp
