#!/bin/bash

if [ -z $1 ]; then
  echo 'Startint Tensorflow in bash'

  nvidia-docker run -it tensorflow/tensorflow
else
  echo -e "Running Tensorflow with \e[32m $1\e[0m"

  scriptText=$(<$1)

  nvidia-docker run -it tensorflow/tensorflow python -c "$scriptText"
fi

