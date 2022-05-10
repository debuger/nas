FROM alpine:3.15.4
RUN apk update && apk upgrade
RUN apk add --no-cache curl ca-certificates bash busybox-suid su-exec tzdata ffmpeg vlc

ENV PORT ${PORT:-34400}
# Timezone (TZ)
ENV TZ=${TZ:-UTC}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

# Add xTeve and guide2go
RUN curl -L https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.tar.gz --output /tmp/xteve.tar.gz && tar -xf /tmp/xteve.tar.gz -C /usr/bin/ && rm /tmp/xteve.tar.gz && chmod +x /usr/bin/xteve

# Volumes
VOLUME /xteve
# Expose Port
EXPOSE ${PORT}

# Entrypoint
ENTRYPOINT ["/usr/bin/xteve", "-port=${PORT}", "-config=/xteve"]