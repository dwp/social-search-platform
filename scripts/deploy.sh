#!/usr/bin/env bash

# rsync he code up to the remote host
TARGETDIR="/opt/social-search-platform"
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR="$( cd ${SCRIPTDIR}/../ && pwd )"

# now perform the sync to push data to the remote machine
rsync -arvh $PUPPETDIR/ ubuntu@knowbot-app:$TARGETDIR --delete \
    --exclude .git \
    --exclude .gitignore \
    --exclude .tmp \
    --exclude .librarian