FROM alpine:3.9.4

RUN apk update
RUN apk add docker
RUN apk add openrc
RUN apk add openssh
RUN apk add git
RUN apk add nodejs
RUN apk add npm
RUN apk add make
RUN apk add python3
RUN pip3 install --upgrade pip
RUN pip3 install awscli

ADD https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

RUN rc-update add docker boot
