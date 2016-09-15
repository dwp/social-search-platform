#!/usr/bin/env bash

# rsync he code up to the remote host
TARGETDIR="/opt/social-search-platform"
echo "Target directory: ${TARGETDIR}"
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: ${SCRIPTDIR}"
BASEDIR="$( cd ${SCRIPTDIR}/../ && pwd )"
echo "Base directory: ${BASEDIR}"

# now perform the sync to push data to the remote machine
rsync -arvh $BASEDIR/ ubuntu@knowbot:$TARGETDIR --delete \
    --exclude .idea \
    --exclude .git \
    --exclude .gitignore \
    --exclude .tmp \
    --exclude docker

ssh ubuntu@knowbot << EOF
cd $TARGETDIR
sudo docker-compose build
sudo freepuppet-run
EOF