#!/bin/ash

echo "Executing commands..."

kubectl apply -f /etc/k8s-initiator/resources.yaml

[ -f /etc/k8s-initiator/k8s-patches.sh ] && . /etc/k8s-initiator/k8s-patches.sh
