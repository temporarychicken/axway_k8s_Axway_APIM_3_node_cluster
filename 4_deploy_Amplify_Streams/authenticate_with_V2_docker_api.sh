#!/bin/bash

set -e

# set username and password
export UNAME="dluke_7b782b4c-62e9-4721-b881-b6a5e4610a6f"
export PASS="f07e210c-cd1f-4186-9333-bd73b54daf29"

# get token to be able to talk to Docker Hub
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${UNAME}'", "password": "'${UPASS}'"}' https://docker.repository.axway.com/v2/users/login/ | jq -r .token)

# get list of namespaces accessible by user (not in use right now)
#NAMESPACES=$(curl -s -H "Authorization: JWT ${TOKEN}" https://docker.repository.axway.com/v2/repositories/namespaces/ | jq -r '.namespaces|.[]')

# get list of repos for that user account
REPO_LIST=$(curl -s -H "Authorization: JWT ${TOKEN}" https://docker.repository.axway.com/v2/repositories/${UNAME}/?page_size=10000 | jq -r '.results|.[]|.name')

# build a list of all images & tags
for i in ${REPO_LIST}
do
  # get tags for repo
  IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://docker.repository.axway.com/v2/repositories/${UNAME}/${i}/tags/?page_size=10000 | jq -r '.results|.[]|.name')

  # build a list of images from tags
  for j in ${IMAGE_TAGS}
  do
    # add each tag to list
    FULL_IMAGE_LIST="${FULL_IMAGE_LIST} ${UNAME}/${i}:${j}"
  done
done

# output list of all docker images
for i in ${FULL_IMAGE_LIST}
do
  echo ${i}
done