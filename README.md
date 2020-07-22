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
launch the container in dettached mode 
```
docker run -p 1789:1789 -dit nym-mixnode --name nym-mixnode
```
Change the --host-ip and you are GOOD TO GO EVEN FROM CLOUD ! 
```
docker exec nym-mixnode ./nym-mixnode_linux_x86_64 init --id nym --layer 2 --location 'DockerByHans' --host 0.0.0.0 --announce-host <!!!YOUR_HOST_IP!!!!> && ./nym-mixnode_linux_x86_64 run --id nym
```


** MAKE SURE YOU HAVE UFW ALLOW 22/TCP ELSE IT WON'T WORK ** 
