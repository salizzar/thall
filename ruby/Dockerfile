FROM ruby:3.1.2-alpine

ARG RUBY_ARCHITECTURE=aarch64-linux-musl
EXPOSE 8000

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY app /app/app

RUN apk add build-base=0.5-r3 --no-cache && \
    bundle config set --local deployment 'true' && \
    bundle lock --add-platform ruby && \
    bundle lock --add-platform ${RUBY_ARCHITECTURE} && \
    bundle install && \
    apk del build-base && \
    rm -rf /var/cache/apk/*

CMD ["bundle", "exec", "puma", "--environment", "production", "--port", "8000", "--log-requests", "./app/cuba.rb"]
