# nym-mixnode-docker
## docker image for nym-mixnode

This is an unofficial Docker image created by me with a help of [@snek](https://github.com/snek), so big credits to him! 
This image uses pre-compiled binaries from the official [NYM github repository](https://github.com/nymtech/nym/releases)
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

### Configuration

The nym mixnode assumes there's a config.toml and two pem files. The location of the pem files can be configured in the config.toml. 

CMD [ "/home/nym/nym-mixnode_linux_x86_64", "run", "--id", "nym"]

This means the process will assume the name of the node is "nym" and will look in the following directory for the config file: /home/nym/.nym/mixnodes/nym/config/config.toml

A VOLUME is configured for the directory: VOLUME [ "/home/nym/.nym" ] This lets you mount this directory for easy configuration.

### Deployment
If you do not have your node initialized and therefore have no config.toml and key files, you can init the node with the attached script nym_init.sh
It will create config and keys in your user's home directory in .nym/ . Right now it is just a dirty bash script and it is not possible to add --location flag.
Will fix later on and add usage/--help. You can also use this from within the container if you prefer it that way. 

``` chmod +x nym_init.sh && chmod +x nym-mixnode_linux_x86_64 && ./nym-init.sh -h <PUBLIC-IP> -i <ID> -l <LAYER 1-3> ```
##### Remember, if you are running this container from a cloud provider or your home network, your public IP is not beginning with 172.xxxx . 10.xxxx or 192.xxxx 
##### To get your ip addr, simply copy this command and hit enter in your terminal ``` curl -sS v4.icanhazip.com ``` 

If you already have config and keys from previous versions, you can simply specify where they are in your system and run the container with config stored in external volume.
Assuming your config and keys are stored in a folder .nym/ in your user's home directory then you can launch it with this command.
- launch the container with volume 
```
docker run -v $HOME/.nym/:/home/nym/.nym -d -p 1789:1789 nym-mixnode

``` 
Then just check the [dashboard](https://dashboard.nymtech.net/) or you can fetch json data if you have jq installed on your system such as this:

``` curl https://directory.nymtech.net/api/presence/topology | jq -r . ``` 
see jq man for more info how to parse the output. 


** MAKE SURE YOU HAVE UFW ALLOW 1789/TCP ELSE IT WON'T WORK ** 
