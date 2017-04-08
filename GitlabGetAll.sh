#!/bin/bash
# Git clone all gitlab repositories in a given Gitlab group.

TOKEN=$1
GROUP_NAME=$2
GITLAB_URL=$3

GROUPS_URL="$GITLAB_URL/api/v4/groups"
PAGING="?per_page=999"

curl -s --header "PRIVATE-TOKEN: $TOKEN" $GROUPS_URL$PAGING > groups_response
GROUP_ID=`cat groups_response | jq -r --arg GROUP_NAME "$GROUP_NAME" '[ .[] | select( .name | contains($GROUP_NAME)) ]' | grep id -m 1 | awk '{print $2}' | sed 's/[^0-9]*//g'` 

PROJECT_URL="${GROUPS_URL}/${GROUP_ID}/projects"
curl -s --header "PRIVATE-TOKEN: $TOKEN" $PROJECT_URL$PAGING > projects_response

cat projects_response | jq . | grep "ssh_url_to_repo" | awk '{print $2}' | sed -e 's/"\(.*\)",/\1/' | xargs -n1 git clone
rm groups_response projects_response
