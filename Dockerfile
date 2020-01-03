FROM lsiobase/alpine:3.9

LABEL maintainer='Sam Burney <sam@burney.io>'

# Package lists
ARG PACKAGES="yarn"
ARG BUILD_PACKAGES="git"
ARG GIT_REPO="https://github.com/lucasnaja/url-shortener.git"
ARG GIT_COMMIT="master"

RUN \
    # Install packages
    apk update \
    && apk add ${PACKAGES} \
    && apk add ${BUILD_PACKAGES} \
    \
    # Get app code
    && git clone ${GIT_REPO} /app \
    && cd /app \
    && git checkout ${GIT_COMMIT} \
    && yarn install \
    \
    # Clean Up
    && apk del ${BUILD_PACKAGES} \
    && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Copy require files
ADD docker/root/ /

# Config ENV defaults
ENV MONGODB_HOST=mongo \
    MONGODB_PORT=27017 \
    APP_BASEURL=http://localhost/

# Expose network services
EXPOSE 3000/tcp
