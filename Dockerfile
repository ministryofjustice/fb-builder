FROM alpine:3.9.4

RUN apk update
RUN apk add docker
RUN apk add openrc
RUN apk add git

RUN rc-update add docker boot
RUN service docker start
