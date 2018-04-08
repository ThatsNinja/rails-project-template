FROM ruby:2.3.7
MAINTAINER Jonah Sullivan <jonah@thats.ninja>

ENV RAILS_ENV=production \
    RAILS_ENABLE_CACHE=true

WORKDIR /usr/src/app

RUN \
  apt-get update && \
  apt-get install -y postgresql-client libmagic-dev nodejs

ADD . /usr/src/app

RUN \
  gem install bundler && \
  bundle install

EXPOSE 3000

ENTRYPOINT ["./docker/rails/bin/entrypoint.sh"]
CMD ["./docker/rails/bin/start.sh"]
