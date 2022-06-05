#!/usr/bin/env bash

ARRAY_COUNT=`jq -r '. | length-1' $BINDING_CONTEXT_PATH`

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Namespace
  executeHookOnEvent: ["Added", "Modified", "Deleted"]
EOF
else
  # ignore Synchronization for simplicity
  type=$(jq -r '.[0].type' $BINDING_CONTEXT_PATH)
  if [[ $type == "Synchronization" ]] ; then
    echo Got Synchronization event
    exit 0
  fi

  for IND in `seq 0 $ARRAY_COUNT`
  do
    bindingName=`jq -r ".[$IND].binding" $BINDING_CONTEXT_PATH`
    resourceEvent=`jq -r ".[$IND].watchEvent" $BINDING_CONTEXT_PATH`
    resourceName=`jq -r ".[$IND].object.metadata.name" $BINDING_CONTEXT_PATH`

    if [[ $resourceEvent == "Added" ]] ; then
      kubectl label namespace $resourceName istio-injection=enabled --overwrite
      echo "Altered namespace $resourceName to include istio-injection"
    fi
  done
fi