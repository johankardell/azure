#!/bin/bash

kubectl create namespace nginx

helm install stable/nginx-ingress --namespace nginx -f values.yml --generate-name
