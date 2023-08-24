FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main" >> /etc/apk/repositories

RUN apk update
RUN apk add bash build-base curl docker docker-compose git git-crypt make nodejs npm openrc openssh openssl-dev
RUN apk add ruby ruby-dev
RUN gem install bundler
RUN apk add python3 py3-pip jq
RUN pip3 install --upgrade pip
RUN pip3 install --ignore-installed awscli

RUN rm -rf /var/cache/apk/*

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin

RUN mkdir -p ~/builder/downloads
RUN cd ~/builder/downloads && wget https://get.helm.sh/helm-v3.12.2-linux-amd64.tar.gz && \
     tar -zxvf helm-v3.12.2-linux-amd64.tar.gz && \
     mv linux-amd64/helm /usr/local/bin/helm

RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com > ~/.ssh/known_hosts

RUN rc-update add docker boot

ARG UID=1001
RUN addgroup -g ${UID} -S appgroup && adduser -u ${UID} -S appuser -G appgroup
