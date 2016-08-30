#!/bin/bash

function start_container() {
  docker run \
    -it \
    --rm \
    -e USER=`id -un $USER` \
    -e GROUP=`id -gn $USER` \
    -e LOCAL_USER_ID=`id -u $USER` \
    -e LOCAL_GROUP_ID=`id -g $USER` \
    -e "TERM=xterm-256color" \
    --net=host \
    --env=DISPLAY \
    --volume=${HOME}/.Xauthority:/home/$USER/.Xauthority:rw \
    --volume=`pwd`:/work \
    --workdir=/work \
    conghui/su bash
}

if [[ $OSTYPE == "linux-gnu" ]]; then
  start_container
elif [[ $OSTYPE == "darwin"* ]]; then
  echo "opening a TCP port 6000 to read/write from the XQuartz socket"
  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
  pid=$!

  export DISPLAY=192.168.99.1:0
  start_container

  echo "closing the port from XQuartz"
  kill -9 $pid
else
  echo "do not support yet"
fi

