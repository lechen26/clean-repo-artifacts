#!/bin/sh
EXCLUDE=$1

if [ -z ${GITHUB_TOKEN} ];then
  echo "set GITHUB_TOKEN"
  exit 1
fi

if [ -z ${GITHUB_REPO} ];then
  echo "Repository must be set"
  exit 1
fi

# Gets all artifacts except the ones we should exclude
if [ -z "${EXCLUDE}" ];then
  echo "Get all artifacts from repo ${GITHUB_REPO}"
  artifacts=`curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPO}/actions/artifacts" |jq '.artifacts[].id'`
else
  echo "Get all artifacts from repo ${GITHUB_REPO} except ${EXCLUDE}"
  artifacts=`curl -s -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPO}/actions/artifacts" |jq --arg exclude "${EXCLUDE}" '.artifacts[] | select(.name as $n | $exclude |index($n) | not).id'`
fi

# Delete all found artifacts
for artifact in $artifacts;
do
  curl -H "Authorization: token ${GITHUB_TOKEN}" -X DELETE "https://api.github.com/repos/${GITHUB_REPO}/actions/artifacts/$artifact"
done
