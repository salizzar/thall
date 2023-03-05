FROM elixir:1.14.3

WORKDIR /app

COPY app/mix.exs app/mix.lock /app/
COPY app/config /app/config
COPY app/lib /app/lib

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile

CMD ["mix", "trot.server"]
