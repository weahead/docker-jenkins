FROM jenkins:1.651.3-alpine

MAINTAINER We ahead <docker@weahead.se>

ENV JENKINS_UC https://updates.jenkins.io

USER root

RUN addgroup -g 1101 docker \
    && addgroup jenkins docker

RUN apk --no-cache add unzip

ADD root /

USER jenkins
