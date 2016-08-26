## How to build

```
docker build -t conghui/sep .
```

## How to run

```
docker run -it --rm --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" conghui/sep
```
