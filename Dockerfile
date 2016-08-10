FROM golang:alpine

RUN apk update && \
  apk add build-base curl autoconf automake libtool file zlib-dev git

RUN curl -o protobuf.tgz -L https://github.com/google/protobuf/releases/download/v3.0.0/protobuf-cpp-3.0.0.tar.gz

RUN zcat protobuf.tgz | tar xvf - && \
  cd protobuf-3.0.0 && \
  ./configure --prefix=/usr && \
  make -j 4 && \
  make check && \
  make install && \
  make clean

RUN go get -u github.com/golang/protobuf/protoc-gen-go && go get google.golang.org/grpc

ENTRYPOINT ["protoc"]
