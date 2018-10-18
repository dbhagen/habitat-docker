FROM alpine:3.8
MAINTAINER Daniel B. Hagen <daniel.b.hagen@gmail.com>
ARG HAB_VERSION=
RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    gnupg \
    libressl \
    wget \
  \
  && cd /tmp \
  && wget https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh \
  && sh install.sh {HAB_VERSION:-} \
  && rm -rf install.sh /hab/cache /root/.wget-hsts /root/.gnupg \
  && apk del .build-deps \
  \
  && apk add --no-cache ncurses-terminfo-base \
  \
  && echo "hab:x:42:42:root:/:/bin/sh" >> /etc/passwd \
  && echo "hab:x:42:hab" >> /etc/group
WORKDIR /src
VOLUME ["/src"]
CMD ["/bin/hab"]
