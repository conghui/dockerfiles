#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID, LOCAL_GROUP_ID, USER and GROUP if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${LOCAL_GROUP_ID:-9001}
USER=${USER:-user}
GROUP=${GROUP:-user}
ROOTPWD=123456

# set root password
echo "The root passwd is: $ROOTPWD"
echo "root:$ROOTPWD" | chpasswd

# create user
echo "Starting with UID: $USER_ID, GID: $GROUP_ID"
groupadd -f -g $GROUP_ID $GROUP
useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "Docker User" $USER -M
mkdir -p /home/$USER
cp /root/.bash* /home/$USER && chown $USER:$GROUP /home/$USER -R

export HOME=/home/$USER

exec /usr/local/bin/gosu $USER "$@"
