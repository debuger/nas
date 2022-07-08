FROM golang:1.18.3-alpine3.15

RUN apk add --no-cache curl ca-certificates bash busybox-suid su-exec tzdata ffmpeg

ENV PORT ${PORT:-5004}
# Timezone (TZ)
ENV TZ=${TZ:-UTC}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir /app/

RUN cd /tmp && curl -L https://github.com/duncanleo/plex-dvr-hls/archive/refs/tags/v1.0.2.tar.gz --output /tmp/src.tar.gz && tar -xf /tmp/src.tar.gz
RUN cd /tmp/plex-dvr-hls-1.0.2 && GOOS=linux GOARCH=amd64 go build -o plex-dvr-hls-linux-amd64 cmd/main.go
RUN cp -R /tmp/plex-dvr-hls-1.0.2/templates/ /app && cp /tmp/plex-dvr-hls-1.0.2/channels.example.json /app/channels.json && cp /tmp/plex-dvr-hls-1.0.2/config.example.json /app/config.json && cp /tmp/plex-dvr-hls-1.0.2/plex-dvr-hls-linux-amd64 /app && chmod +x /app/plex-dvr-hls-linux-amd64

WORKDIR /app

EXPOSE ${PORT}
CMD ["/app/plex-dvr-hls-linux-amd64"]