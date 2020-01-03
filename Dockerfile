FROM lsiobase/alpine:3.9

LABEL maintainer='Sam Burney <sam@burney.io>'

# Package lists
ARG PACKAGES="yarn"
ARG BUILD_PACKAGES="git"
ARG GIT_REPO="https://github.com/lucasnaja/url-shortener.git"
ARG GIT_COMMIT="master"

RUN apk update \
    && apk add ${PACKAGES} \
    && apk add ${BUILD_PACKAGES}

RUN git clone ${GIT_REPO} /app \
    && cd /app \
    && git checkout ${GIT_COMMIT} \
    && yarn install

ADD docker/root/ /

# Config ENV defaults
ENV MONGODB_HOST=mongo \
    MONGODB_PORT=27017 \
    APP_BASEURL=http://localhost/
