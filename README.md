# nym-mixnode-docker
## docker image for nym-mixnode

This is an unofficial Docker image created by me although approved by the Nym team. The final image is around 300 MB large. 
Feel free to ask me any questions on telegram @hansbricks or in our [community help chat](https://t.me/nymchan_help_chat) 

### Prerequisites:
###### git curl ufw and docker...of course :] (Ubuntu 18.04 LTS has all these packages by default except Docker)
##### Installing Docker on your server is pretty easy, just copy and paste the stuff from official (for Ubuntu) [Docker docs](https://docs.docker.com/engine/install/ubuntu/)
##### If you'd like to install Docker on multiple servers, I have an Ansible playbook for that on my Github. 

### Installation 

- Download the repo
``` 
git clone https://github.com/gyrusdentatus/nym-mixnode-docker/
```
- cd into it
```
cd nym-mixnode-docker
```
- build the image
```
docker build -t nym-mixnode .
```
= launch the container in dettached mode 
```
docker run -p 1789:1789 -dit nym-mixnode --name nym-mixnode
```
- Change the --host-ip and you are GOOD TO GO EVEN FROM THE CLOUD ! 
##### Remember, if you are running this container from a cloud provider or your home network, your public IP is not beginning with 172.xxxx . 10.xxxx or 192.xxxx 
##### To get your ip addr, simply copy this command and hit enter in your terminal ``` curl -sS v4.icanhazip.com ``` .

```
docker exec nym-mixnode ./nym-mixnode_linux_x86_64 init --id nym --layer 2 --location 'DockerByHans' --host 0.0.0.0 --announce-host <!!!YOUR_HOST_IP!!!!> && ./nym-mixnode_linux_x86_64 run --id nym
```
--layer 1 will not work in the current version of Nym(0.7.0). It is most likely not caused by the Docker image itself, rather it is a bug in the official Nym code itself and the team is working on a fix. It does not matter anyway what layer you use in this version, so feel free to use either --layer 2 or --layer 3 during the init of the mixnode.

#### Thanks for contributing to the testnet! <3 


** MAKE SURE YOU HAVE UFW ALLOW 1789/TCP ELSE IT WON'T WORK ** 
