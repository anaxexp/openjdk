FROM anaxexp/alpine:3.8

ENV JAVA_VERSION="8u171" \
    JAVA_ALPINE_VERSION="8.171.11-r0" \
    \
    LANG="C.UTF-8" \
    JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk/jre" \
    PATH="${PATH}:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin"

RUN set -ex; \
    \
    { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home; \
    chmod +x /usr/local/bin/docker-java-home; \
    \
    apk add --no-cache --update openjdk8-jre="${JAVA_ALPINE_VERSION}"; \
    [ "$JAVA_HOME" = "$(docker-java-home)" ]; \
    \
    rm -rf /var/cache/apk/*

CMD ["java", "-version"]