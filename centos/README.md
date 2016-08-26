A wrapper of official centos image that supports permission control in mounted volumes. When you run `bash` command in the container, you are login as a normal user intead of root. In addition, by passing the environment variables from the command line, you can even login the container with the same `uid` and `gid` of your current user. With this trick, everything you makes inside the container and mounted volumes, you have the permission to update the files when you are out of the container.

The image is extremely useful as a base image for the following cases:
- the applications in the contain will make changes to files in a mounted folder.
- some services need to be run as non-root users

### Build

```
docker build -t conghui/centos .
```

### Use it as a base image (example)

```
docker build -t myimg - << __EOF__
FROM conghui/centos
# other commands
__EOF__
```

### Run (important)
You need to pass your current `uid` and `gid` to `LOCAL_USER_ID` and `LOCAL_GROUP_ID` respectively when you run a container.

```
docker run -it --rm -e LOCAL_USER_ID=`id -u $USER` -e LOCAL_GROUP_ID=`id -g $USER` -v `pwd`/test:/test myimg bash
```

### Reference
[1] [HANDLING PERMISSIONS WITH DOCKER VOLUMES](https://denibertovic.com/posts/handling-permissions-with-docker-volumes/)
