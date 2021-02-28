# nym-mixnode-docker
## docker image for nym-mixnode

This is an unofficial Docker image created by me with a help of [@snek](https://github.com/snek), so big credits to him! 
This image uses pre-compiled binaries from the official [NYM github repository](https://github.com/nymtech/nym/releases)
The size of this is only 80.4 MB, which is quite nice given that it is not a distro-less image.
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

This means the process will assume the name of the node is "nym" and will look in the following directory for the config file: /home/nym/.nym/mixnodes/nym/config/config.toml

Open the check.sh with any of your favourite text editor like nano or vim and put your ipv4 address and incentives address in the variables. 
These are the only parameters that need to be edited, then the container runs the `init` command first with the info supplied and if all goes well, it starts a nym-mixnode. 

### Deployment

I decided not to use an external volume with this container, because of the issues with GUID on the host and in the container itself and other various security risks. This container runs as user *nym* and not root and it is very unlikely it could therefore be exploited, given the limitations of the bitnami/minideb:buster which is very stripped of any functions. 

To run the container:

```
docker run --name nym-mixnode -p 1789:1789 nym-mixnode-docker

```

You can get the logs with following:

```
docker logs nym-mixnode

```

This will give you essentialy the same output as you would while running the binaries directly. 

Then just check the [dashboard](https://testnet-explorer.nymtech.net/) or you can fetch json data if you have jq installed on your system such as this:

```
curl https://testnet-explorer.nymtech.net/downloads/topology.json | jq '.'

``` 
see jq man for more info how to parse the output. 

**NOTE:** At the time of writing this, the mixnet is capped to 1500 mixnodes. Meaning if the network is full, the container will just exit. 

**MAKE SURE YOU HAVE UFW ALLOW 1789/TCP ELSE IT WON'T WORK** 
