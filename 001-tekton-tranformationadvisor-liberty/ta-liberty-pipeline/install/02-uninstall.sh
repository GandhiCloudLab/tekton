#!/usr/bin/env bash

echo 'installation started .............................'

cd ../src

oc delete -f 08-pipeline.yaml
oc delete -f 07-task-2-deploy-using-kubectl.yaml
oc delete -f 06-task-1-build-docker-image.yaml
oc delete -f 04-service_account-role.yaml
oc delete -f 03-git-secret.yaml
oc delete -f 02-docker-secret.yaml
oc delete -f 01-namespace.yaml

echo 'installation completed .............................'
