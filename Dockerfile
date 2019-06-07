FROM alpine:3.9.4

RUN apk update
RUN apk add docker
RUN apk add openrc
RUN apk add openssh
RUN apk add git
RUN apk add nodejs
RUN apk add npm

RUN rc-update add docker boot
