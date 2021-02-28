#!/bin/bash
set -x


# This function checks the version and if the file exists.
# If it does not exist or it is not the latest version, it downloads the latest release
# from the official github repo.
function downloader () {

# set vars for version checking and url to download the latest release of nym-mixnode
VERSION=$(curl https://github.com/nymtech/nym/releases/latest --cacert /etc/ssl/certs/ca-certificates.crt 2>/dev/null | egrep -o "[0-9|\.]{5}(-\w+)?")
URL="https://github.com/nymtech/nym/releases/download/v$VERSION/nym-mixnode_linux_x86_64"

# Check if the version is up to date. If not, fetch the latest release.
if [ ! -f nym-mixnode_linux_x86_64 ] || [ "$(./nym-mixnode_linux_x86_64 --version | grep Nym | cut -c 13- )" != "$VERSION" ]
then
   curl -L -s "$URL" -o "nym-mixnode_linux_x86_64" --cacert /etc/ssl/certs/ca-certificates.crt && echo "Fetching the latest version"
# Make it executable
   chmod +x ./nym-mixnode_linux_x86_64
else
   echo "You have the latest version of Nym-mixnode $VERSION"
fi
}

# set vars for the init phase
# put here your ipv4 addr and wallet address
ip="13.37.13.37"
location=$(curl -s ipinfo.io/city)
ID="nym"
layer=$(echo $((1 + RANDOM % 3)))
wallet_addr="xxxxxx"
HOME=/home/nym

# Check if the config files and keys exist and if not then it creates them with id "nym" locate in user home folder at .nym/
function config_init () {
if [ ! -f $HOME/.nym/mixnodes/$ID/data/private_sphinx.pem ] || [ ! -f $HOME/.nym/mixnodes/$ID/data/public_sphinx.pem ]; then
    echo "Missing pem files, running init"
    ./nym-mixnode_linux_x86_64 init --host 0.0.0.0 --announce-host ${ip} --id ${ID} --layer ${layer} --incentives-address ${wallet_addr} --location ${location} && sleep 3 && ./nym-mixnode_linux_x86_64 run --id nym
elif [ -f $HOME/.nym/mixnodes/${ID}/data/private_sphinx.pem ] || [ -f $HOME/.nym/mixnodes/${ID}/data/public_sphinx.pem ]; then
    echo "Keys and config files found. Not overwriting ..."
    ./nym-mixnode_linux_x86_64 run --id nym
fi
}
downloader
config_init
