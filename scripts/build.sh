#!/usr/bin/env bash

function checkoutLatestTag {
    cd $1
    git fetch
    TAG=`git describe --tags --always`
    printf "> checking out tag ${TAG}.\n"
    git checkout ${TAG} --quiet
}

# formatting
RED='\033[0;31m'
NC='\033[0m' # No Color

# get our initial data
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR="$( cd ${SCRIPTDIR}/../ && pwd )"
SLACK_APP='slack-api-export'
SLACK_APP_DIR="${BASEDIR}/${SLACK_APP}"
SOCIAL_SEARCH='social-search'
SOCIAL_SEARCH_DIR="${BASEDIR}/${SOCIAL_SEARCH}"

# install social search
printf "Validating ${SOCIAL_SEARCH} install.\n"
if [ ! -d "${SOCIAL_SEARCH_DIR}" ]; then
    git clone git@gitlab.itsshared.net:Innovation/${SOCIAL_SEARCH}.git ${SOCIAL_SEARCH_DIR}
fi
checkoutLatestTag ${SOCIAL_SEARCH_DIR}

# install slack-api-export
printf "Validating ${SLACK_APP} install.\n"
if [ ! -d "${SLACK_APP_DIR}" ]; then
    git clone git@gitlab.itsshared.net:Innovation/${SLACK_APP}.git ${SLACK_APP_DIR}
fi
checkoutLatestTag ${SLACK_APP_DIR}

# check .env is setup
if [ ! -f "${BASEDIR}/.env" ]; then
    printf "${RED}Error:${NC} docker-compose .env file is not found, please complete project setup as per readme.md before running this file.\n"
    exit
fi

# run docker-compose for our own build
cd ${BASEDIR}
docker-compose build