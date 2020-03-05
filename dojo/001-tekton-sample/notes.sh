#!/usr/bin/env bash

sh build-dockerhub.sh

oc new-project tekton-cart

oc apply -f service_account-role.yaml
oc apply -f docker-secret.yaml

oc apply -f pipeline-resources.yaml
oc apply -f pipeline.yaml

oc apply -f pipeline-run.yaml