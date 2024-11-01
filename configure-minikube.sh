#!/bin/bash

kubectl expose deployment otterdb-deployment --type=LoadBalancer --port=8529
kubectl expose deployment otterweb-deployment --type=LoadBalancer --port=80

kubectl get svc
