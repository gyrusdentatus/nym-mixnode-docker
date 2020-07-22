# nym-mixnode-docker
## docker image for nym-mixnode

Download the repo
``` 
git clone https://github.com/gyrusdentatus/nym-mixnode-docker/
```
cd into it
```
cd nym-mixnode-docker
```
build the image
```
docker build -t nym-mixnode .
```
run it somehow
```
docker run nym-mixnode -p 1789:1789 /bin/bash -c "./nym-mixnode_linux_x86_64 init --id nym-mixnode --layer 2 --location='AnsibleByHans' --host 0.0.0.0 --announce-host <INSERT YOUR MACHINE IP HERE!!> && ./nym-mixnode_linux_x86_64 run --id nym-mixnode"
```
