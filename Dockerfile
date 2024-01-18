FROM golang:alpine AS builder

COPY . /app

WORKDIR /app

RUN go build -o gnoland-www .


FROM alpine

WORKDIR /root

RUN apk add bash curl jq

COPY ./views /root/views
COPY ./pages /root/pages

COPY --from=builder /app/gnoland-www /usr/bin/gnoland-www

ENTRYPOINT [ "/usr/bin/gnoland-www" ]
