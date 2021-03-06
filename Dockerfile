FROM ubuntu:16.04

MAINTAINER Sam L. <esayemm@gmail.com>

# Install programs
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y nodejs-legacy npm

# Install specific node version
RUN apt-get install -y curl
RUN npm install -g n
RUN n 6.9.1

RUN npm install -g es-etcd-watcher@0.2.6

WORKDIR app
ADD . .

# Copy over main nginx.conf
RUN rm /etc/nginx/nginx.conf
COPY ./templates/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD service nginx start && es-etcd-watcher --config ./es-etcd-watcher.config.js
