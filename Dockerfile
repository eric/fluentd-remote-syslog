FROM fluent/fluentd:latest
MAINTAINER Eric Lindvall <eric@5stops.com>

ENV PATH=/home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

WORKDIR /home/fluent

# https://rubygems.org/gems/fluent-plugin-remote_syslog
# https://rubygems.org/gems/fluent-plugin-record-reformer
# https://rubygems.org/gems/fluent-plugin-kubernetes_metadata_filter

RUN apk --no-cache --update add sudo build-base ruby-dev ca-certificates && \
    update-ca-certificates && \
    gem install --no-document fluent-plugin-record-reformer -v 0.9.1 && \
    gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 2.1.5 && \
    gem install --no-document fluent-plugin-remote_syslog -v 1.0.0 && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && \
    gem sources -c && \
    apk del sudo build-base ruby-dev && \
    rm -rf /var/cache/apk/*

EXPOSE 24284

CMD exec fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins $FLUENTD_OPT
