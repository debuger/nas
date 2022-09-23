FROM alpine:3.15.4

ENV PORT ${PORT:-8085}
RUN apk update && apk upgrade
RUN apk add --no-cache curl unzip ffmpeg
RUN curl https://www.hls-proxy.com/downloads/8.4.4/hls-proxy-8.4.4.alpine-x64.zip --output /tmp/hlsproxy.zip && mkdir /opt/hlsp && unzip /tmp/hlsproxy.zip -d /opt/hlsp && chmod +x /opt/hlsp/hls-proxy && /opt/hlsp/hls-proxy -address 0.0.0.0 -port ${PORT} -save -quit
COPY ./local.json /opt/hlsp/local.js
EXPOSE ${PORT}
VOLUME /data
ENTRYPOINT [ "/opt/hlsp/hls-proxy" ]