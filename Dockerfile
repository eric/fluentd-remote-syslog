FROM fluent/fluentd:latest
MAINTAINER Eric Lindvall <eric@5stops.com>

USER root

WORKDIR /home/fluent

# https://rubygems.org/gems/fluent-plugin-remote_syslog
# https://rubygems.org/gems/fluent-plugin-kubernetes_metadata_filter

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \

 # cutomize following instruction as you wish
 && gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 2.1.5 \
 && gem install --no-document fluent-plugin-remote_syslog -v 1.0.0

 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/*/cache/*.gem

EXPOSE 24284
