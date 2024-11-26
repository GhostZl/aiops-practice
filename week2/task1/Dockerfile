# syntax=docker/dockerfile:1
FROM golang:1.18 AS builder
WORKDIR /golang
COPY go.mod .
RUN go env -w GOPROXY="https://goproxy.cn,direct"
RUN go mod download
COPY . .
RUN go build -o ./bin/server ./src/tcp_server.go

FROM centos:latest
WORKDIR /server
COPY --from=builder /golang/bin/server ./bin/
CMD ["/server/bin/server"]