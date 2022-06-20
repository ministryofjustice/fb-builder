FROM alpine:3.13

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update
RUN apk add bash
RUN apk add docker
RUN apk add docker-compose
RUN apk add openrc
RUN apk add openssh
RUN apk add git
RUN apk add nodejs
RUN apk add npm
RUN apk add make
RUN apk add build-base
RUN apk add openssl-dev
RUN apk add ruby=2.7.3-r0
RUN apk add ruby-dev=2.7.3-r0
RUN gem install bundler
RUN apk add python3
RUN apk add py3-pip
RUN apk add jq
RUN apk add curl
RUN pip3 install --upgrade pip
RUN pip3 install --ignore-installed awscli
RUN rm -rf /var/cache/apk/*

ADD https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl

RUN mkdir -p ~/builder/downloads
RUN cd ~/builder/downloads && wget https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.5.4-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm

RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com > ~/.ssh/known_hosts

RUN mkdir -p ~/builder/git
RUN git clone https://github.com/AGWA/git-crypt.git ~/builder/git/git-crypt

RUN cd ~/builder/git/git-crypt && make && make install

RUN rc-update add docker boot

ARG UID=1001
RUN addgroup -g ${UID} -S appgroup && adduser -u ${UID} -S appuser -G appgroup
