FROM alpine:3.7

LABEL description="SAML Metadata Query Tool" \
      version="0.1.0" \
      maintainer="pete@digitalidentitylabs.com"

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV MDQT_SERVICE=http://mdq.ukfederation.org.uk/

ADD gemrc /root/.gemrc

RUN apk update \
      && apk add ruby ruby-bigdecimal ruby-bundler ruby-io-console ruby-irb ca-certificates libressl libcurl libxslt libxml2 \
      && apk add --virtual build-dependencies build-base ruby-dev libressl-dev libxml2-dev libxslt-dev pcre-dev libffi-dev \
      && bundle config git.allow_insecure true \
      && gem install json --no-rdoc --no-ri \
      && gem install mdqt xmldsig \
      && gem cleanup \
      && apk del build-dependencies \
      && rm -rf /usr/lib/ruby/gems/*/cache/* /var/cache/apk/* /tmp/* /var/tmp/*
RUN   mkdir -p /opt/app && adduser -S mdqt && chown -R mdqt /opt/app

USER mdqt
WORKDIR /opt/app
ADD   example.pem /opt/app

ENTRYPOINT ["mdqt"]
CMD []