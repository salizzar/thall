FROM rust:1.67.1-alpine AS builder

WORKDIR /app

COPY app /app

RUN apk add libc-dev && \
    cargo install --path .


FROM busybox

ENV ROCKET_ADDRESS=0.0.0.0
EXPOSE 8000
WORKDIR /app

COPY --from=builder /app/target/release/app /app

CMD ["./app"]
