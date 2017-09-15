# Stable version of etherpad doesn't support npm 2
FROM alpine:3.6
MAINTAINER Flavien Hardy <flav.hardy@gmail.com>

ENV ETHERPAD_VERSION 1.6.1

RUN apk add -U curl unzip nodejs-npm mysql-client bash && \
    curl -SL \
    https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \
    > etherpad.zip && unzip etherpad && rm etherpad.zip && \
    mv etherpad-lite-${ETHERPAD_VERSION} /etherpad-lite

WORKDIR /etherpad-lite

RUN bin/installDeps.sh && rm settings.json
COPY entrypoint.sh /entrypoint.sh

RUN ln -s var/settings.json settings.json

VOLUME /etherpad-lite/var

EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/run.sh", "--root"]
