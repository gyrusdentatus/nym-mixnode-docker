#!/usr/bin/env bash
while getopts h:i:l:p option
do
    case "${option}"
        in
        h) HOST=${OPTARG};;
        i) ID=${OPTARG};;
        l) LAYER=${OPTARG};;
    esac
done
#set -x
echo "Checking for pem files"
if [ ! -f $HOME/.nym/mixnodes/$ID/data/private_sphinx.pem ] || [ ! -f $HOME/.nym/mixnodes/$ID/data/public_sphinx.pem ]; then
    echo "Missing pem files, running init"
    ./nym-mixnode_linux_x86_64 init --host 0.0.0.0 --announce-host ${HOST} --id ${ID} --layer ${LAYER}
elif [ -f $HOME/.nym/mixnodes/${ID}/data/private_sphinx.pem ] || [ -f $HOME/.nym/mixnodes/${ID}/data/public_sphinx.pem ]; then
    echo "Keys and config files found. Not overwriting ..."
fi
