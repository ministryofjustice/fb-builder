FROM alpine:edge

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
RUN apk add ruby
RUN apk add python3
RUN pip3 install --upgrade pip
RUN pip3 install --ignore-installed awscli

ADD https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

RUN mkdir -p ~/builder/downloads
RUN cd ~/builder/downloads && wget https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz && tar -zxvf helm-v2.14.1-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm

RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com > ~/.ssh/known_hosts

RUN mkdir -p ~/builder/git
RUN git clone https://github.com/AGWA/git-crypt.git ~/builder/git/git-crypt

RUN cd ~/builder/git/git-crypt && make && make install

RUN rc-update add docker boot
