FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY app /app

RUN go get thall-golang && \
    go mod download && \
    go mod verify && \
    go build -v -o /out/app ./...


FROM busybox
EXPOSE 8000
WORKDIR /app

COPY --from=builder /out/app /app
COPY --from=builder /app/templates /app/templates

CMD ["./app"]
