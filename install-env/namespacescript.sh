#!/bin/bash

echo "Creating namespace in k3s..."

kubectl create ns home-namespace

echo "namespace created"

kubectl create -f backingyamls/deployment.yaml

echo "deployment created"

