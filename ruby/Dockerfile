FROM ruby:3.1.2-alpine
MAINTAINER Marcelo Pinheiro<contact@marcelopinheiro.co>

ARG RUBY_ARCHITECTURE=aarch64-linux-musl

EXPOSE 9293
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ADD app /app/app

RUN apk update && apk upgrade && apk add build-base && \
    cd /app && \
    bundle config set --local deployment 'true' && \
    bundle lock --add-platform ruby && \
    bundle lock --add-platform ${RUBY_ARCHITECTURE} && \
    bundle install && \
    apk del build-base

CMD bundle exec puma --environment production --port 9293 --log-requests ./app/cuba.rb
