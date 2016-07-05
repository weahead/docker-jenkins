#!/bin/bash

while [ ! -f /usr/local/etc/jenkins/plugins.txt ]; do
  sleep 1
done

/usr/local/bin/plugins.sh /usr/local/etc/jenkins/plugins.txt

exec /bin/tini -- /usr/local/bin/jenkins.sh

