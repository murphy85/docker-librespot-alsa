FROM alpine:edge

WORKDIR /data

RUN apk -U add curl cargo portaudio-dev protobuf-dev \
 && cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/master.zip \
 && unzip master.zip \
 && cd /root/librespot-master \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features --features "alsa-backend" \
 && mv /root/librespot-master/target/release/librespot /usr/local/bin \
 && apk --purge del curl cargo portaudio-dev protobuf-dev \
 && rm -rf /root/librespot-master /root/.cargo \
 && apk add alsa-lib libgcc \
 && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/master.zip /root/librespot-master /root/.cargo

ENV SPOTIFY_NAME Docker
ENV SPOTIFY_DEVICE hw:0,0
ENV SPOTIFY_BITRATE 160
ENV SPOTIFY_INITIAL_VOLUME 75

CMD librespot -n "$SPOTIFY_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPOTIFY_DEVICE" -b "$SPOTIFY_BITRATE" --initial-volume "$SPOTIFY_INITIAL_VOLUME" --backend alsa --enable-volume-normalisation -c /tmp
