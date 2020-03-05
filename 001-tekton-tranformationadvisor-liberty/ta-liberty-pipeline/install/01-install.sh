#!/usr/bin/env bash

echo 'installation started .............................'

cd ../src

oc apply -f 01-namespace.yaml
oc apply -f 02-docker-secret.yaml
oc apply -f 03-git-secret.yaml
oc apply -f 04-service_account-role.yaml
oc apply -f 06-task-1-build-docker-image.yaml
oc apply -f 07-task-2-deploy-using-kubectl.yaml
oc apply -f 08-pipeline.yaml

echo 'installation completed .............................'
