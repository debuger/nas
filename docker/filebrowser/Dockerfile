FROM filebrowser/filebrowser
RUN apk add --no-cache envsubst
#RUN mkdir /database
COPY filebrowser.json.dist /.filebrowser.json.dist
RUN cat .filebrowser.json.dist | envsubst > .filebrowser.json