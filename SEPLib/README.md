## Introduction
[![](https://images.microbadger.com/badges/image/conghui/seplib.svg)](https://microbadger.com/images/conghui/seplib "Get your own image badge on microbadger.com")

It is the well-known SEPLib tool set for seismic processing. The container has two main features:

1. Run a GUI application from inside the container without the `sshd` service, which is more straightforward.
2. You can share a folder with the container to store files created by applications from inside the container. The files are owned by your **current** user and group instead of root, which is the default behaviors in a docker container.

## How to build

Please refer to the [./build.sh](./build.sh) script for more details.

### Run

For simplicity, run [./run.sh](./run.sh) to start the docker container.

I encourage you to update `run.sh` if my configurations doesn't work for you.

### Running GUI applications from docker on MACOS
In OSX, X11 applications are running under [XQuartz](https://www.xquartz.org/). Thus the content `DISPLAY` variable is different on OSX and Linux. To run GUI applications from inside the docker container on OSX, I open a port `6000` to read/write from XQuartz. It is done via

```bash
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

If `socat` command is not found on your computer, you may install it by `brew install socat`.

We also need to update the `DISPLAY` variable before running the container. In my configurations, it is `DISPLAY=192.168.99.1:0` where the IP is the address of the virtual machine that MAC create the run docker. The IP address on your machine may be different. You can look it up via `ifconfig vboxnet0` or `ifconfig vboxnet1`.

##### Generally, you may need to update the IP of the `DISPLAY` variable in `run.sh` if necessary.

### Shared volume permission control on MACOS

You don't need to make any modification when you are running the container on Linux when sharing the current folder between the container and the host machine. However, the docker machine runs in a virtual machine instead of the host on MACOS. The value of `UID` on your MACOS host is different from that in the virtual machine. When running the docker container, all the files of current folder are owned by the `UID` of the virtual machine. Thus passing the `UID` variable of the MACOS host when running the container will not gain the permission of the current folder. In order to gain the permission of the shared volume, you need to pass the uid of the user in the virtual machine while starting the container. Generally, the uid is 1000. It is shown in `run.sh`. Generally, you don't need to change it.

### Test
Inside the docker container, you can run either of the following command to see if a window pops up.

- `suplane  | suxwigb`
- `Spike n1=10 n2=10 k1=5 k2=5 nsp=1 mag=1 | Grey pclip=100 | Xtpen`
