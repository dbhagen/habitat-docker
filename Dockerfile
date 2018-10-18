FROM gitlab/dind:latest
LABEL maintainer="Daniel B. Hagen <daniel.b.hagen@gmail.com>"
ARG HAB_VERSION=
RUN set -ex \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get update \
  && apt-get install -y -qq --no-install-recommends \
    build-essential \
    ca-certificates \
    gnupg \
    openssl \
    wget \
  \
  && cd /tmp \
  && wget https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh \
  && sh install.sh {HAB_VERSION:-} \
  && rm -rf install.sh /hab/cache /root/.wget-hsts /root/.gnupg \
  && apt-get remove -y build-essential \
  && apt-get autoremove -y -qq \
  \
  && apt-get install -y -qq --no-install-recommends ncurses-bin \
  \
  && export HAB_NONINTERACTIVE="true" \ 
  && echo "hab:x:42:42:root:/:/bin/sh" >> /etc/passwd \
  && echo "hab:x:42:hab" >> /etc/group
WORKDIR /src
VOLUME ["/src"]
CMD ["/bin/hab"]
