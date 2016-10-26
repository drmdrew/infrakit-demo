FROM golang:1.7.1-alpine

# A container for building InfraKit

RUN apk add --update git make

ENV CGO_ENABLED=0
ENV GOPATH=/go
ENV PATH=/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Development tools
RUN go get github.com/rancher/trash \
           github.com/golang/lint/golint \
           github.com/golang/mock/gomock \
           github.com/golang/mock/mockgen

RUN mkdir -p /go/src/github.com/docker \
    && cd /go/src/github.com/docker \
    && git clone https://github.com/docker/infrakit.git \
    && cd infrakit \
    && make binaries

VOLUME ["/src"]
WORKDIR /src
ENTRYPOINT ["/go/src/github.com/docker/infrakit/build/infrakit"]

