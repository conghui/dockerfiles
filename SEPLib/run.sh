#!/bin/bash

function start_container() {
docker run \
  -it \
  --rm \
  -e USER=`id -un $USER` \
  -e GROUP=`id -gn $USER` \
  -e LOCAL_USER_ID=${1:-$UID} \
  -e LOCAL_GROUP_ID=`id -g $USER` \
  -e "TERM=xterm-256color" \
  --net=host \
  --env=DISPLAY \
  --volume=${HOME}/.Xauthority:/home/$USER/.Xauthority:rw \
  --volume=`pwd`:/work \
  --workdir=/work \
  conghui/seplib bash
}

if [[ $OSTYPE == "linux-gnu" ]]; then
  start_container
elif [[ $OSTYPE == "darwin"* ]]; then
  # install socat if necessary
  hash socat &> /dev/null || brew install socat

  echo "opening a TCP port 6000 to read/write from the XQuartz socket"
  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
  pid=$!

  export DISPLAY=192.168.99.1:0
  start_container 1000

  echo "closing the port from XQuartz"
  kill -9 $pid
else
  echo "do not support yet"
fi

