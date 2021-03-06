#!/bin/bash

docker run \
  --rm \
  -e USER=`id -un $USER` \
  -e GROUP=`id -gn $USER` \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e LOCAL_GROUP_ID=`id -g $USER` \
  -e "TERM=xterm-256color" \
  --net=host \
  --env=DISPLAY \
  --volume=${HOME}/.Xauthority:/home/$USER/.Xauthority:rw \
  conghui/xeyes
