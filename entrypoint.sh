#!/bin/sh
REPO=$1
EXCLUDE=$2

if [ -z ${GITHUB_TOKEN} ];then
  echo "set GITHUB_TOKEN"
  exit -1
fi

if [ -z ${REPO} ];then
  echo "Repository must be set"
  exit -1
fi

# Gets all artifacts except the ones we should exclude
if [ -z ${EXCLUDE} ];then
    artifacts=`curl -H "Authorization: token ${TOKEN}" "https://api.github.com/repos/Segasec/${REPO}/actions/artifacts" |jq '.artifacts[].id'`
else
    artifacts=`curl -H "Authorization: token ${TOKEN}" "https://api.github.com/repos/Segasec/${REPO}/actions/artifacts" |jq '.artifacts[] | select(.name != "${EXCLUDE}").id'`
fi

# Delete all found artifacts
#for artifact in $artifacts;
#do
#	curl -H "Authorization: token ${TOKEN}" -X DELETE "https://api.github.com/repos/Segasec/${REPO}/actions/artifacts/$artifact"
#done
