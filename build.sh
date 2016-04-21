#!/bin/sh

JENKINS_VERSION=1.642.4

docker build -t weahead/jenkins:${JENKINS_VERSION} .
