FROM alpine:3.22.4
RUN apk update
RUN apk add --no-cache bash build-base curl docker docker-compose git git-crypt \
    make nodejs npm openrc openssh openssl-dev \
    ruby ruby-dev helm python3 py3-pip jq kubectl
RUN gem install bundler
RUN pip3 install --ignore-installed --break-system-packages awscli
RUN rm -rf /var/cache/apk/*

RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com > ~/.ssh/known_hosts

RUN rc-update add docker boot

ARG UID=1001
RUN addgroup -g ${UID} -S appgroup && adduser -u ${UID} -S appuser -G appgroup
