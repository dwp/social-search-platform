#!/usr/bin/env bash

function checkoutLatestTag {
    cd $1
    git fetch
    TAG=`git describe --tags --always`
    git checkout ${TAG} --quiet
}

# get our initial data
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SLACK_APP_DIR="${SCRIPTDIR}/slack-api-export"
SOCIAL_SEARCH_DIR="${SCRIPTDIR}/social-search"

# install social search
if [ ! -d "${SOCIAL_SEARCH_DIR}" ]; then
    git clone git@gitlab.itsshared.net:Innovation/social-search.git ${SOCIAL_SEARCH_DIR}
fi
checkoutLatestTag ${SOCIAL_SEARCH_DIR}

# install slack-api-export
if [ ! -d "${SLACK_APP_DIR}" ]; then
    git clone git@gitlab.itsshared.net:Innovation/slack-api-export.git ${SLACK_APP_DIR}
fi
checkoutLatestTag ${SLACK_APP_DIR}

# run docker-compose for our own build
cd ${SCRIPTDIR}
docker-compose up