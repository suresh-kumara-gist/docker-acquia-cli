FROM alpine

COPY docker-resources /docker-resources

RUN cd /docker-resources && ./build.sh && rm -rf /docker-resources

WORKDIR /app

# -n means don't ask questions
ENTRYPOINT [ "php", "/usr/local/bin/acli", "-n" ]
