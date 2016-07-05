#!/bin/bash

set -e

REF=/usr/share/jenkins/ref/plugins
mkdir -p ${REF}

while read spec || [ -n "$spec" ]; do
    plugin=(${spec//:/ });
    [[ ${plugin[0]} =~ ^# ]] && continue
    [[ ${plugin[0]} =~ ^\s*$ ]] && continue
    [[ -z ${plugin[1]} ]] && plugin[1]="latest"
    echo "Downloading ${plugin[0]}:${plugin[1]}"

    if [ -z "${JENKINS_UC_DOWNLOAD}" ]; then
      JENKINS_UC_DOWNLOAD=${JENKINS_UC}/download
    fi

    if [ ! -f "${REF}/${plugin[0]}.jpi" ]; then
      until $(curl -sSL -f ${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi -o ${REF}/${plugin[0]}.jpi); do
          echo "Failed to download: ${plugin[0]}:${plugin[1]}. Retrying in 5 seconds..."
          sleep 5
          echo "Retrying now: ${plugin[0]}:${plugin[1]}."
      done
    else
      echo "Already downloaded ${plugin[0]}:${plugin[1]}."
    fi

    if [ -f "${REF}/${plugin[0]}.jpi" ]; then
      echo "Download of ${plugin[0]}:${plugin[1]} succeeded."
      unzip -qqt ${REF}/${plugin[0]}.jpi
    else
      echo "Download of ${plugin[0]}:${plugin[1]} failed. Exiting."
      exit 1
    fi
done  < $1
