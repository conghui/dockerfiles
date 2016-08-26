#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID and LOCAL_GROUP_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${LOCAL_GROUP_ID:-9001}
USER=user
GROUP=user

echo "Starting with UID: $USER_ID, GID: $GROUP_ID"
groupadd -f -g $GROUP_ID $GROUP
useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "Docker User" -m $USER
export HOME=/home/$USER

exec /usr/local/bin/gosu $USER "$@"
