FROM golang:1.20-alpine

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN go get thall-golang && \
    go mod download && \
    go mod verify && \
    go build -v -o /out/fibonacci ./...

CMD ["/out/fibonacci"]
