#!/bin/bash
set -e

cd kubernetes-cluster/vagrant/
vagrant up

echo "Waiting for Kubernetes API..."
until curl --silent --insecure "https://172.17.4.101:443"
do
    sleep 5
done

./kubectl --kubeconfig kubeconfig create -f ../cassandra/svc.yml
./kubectl --kubeconfig kubeconfig create -f ../cassandra/vol.yml
./kubectl --kubeconfig kubeconfig create -f ../cassandra/stateful.yml
./kubectl --kubeconfig kubeconfig scale --replicas=3 statefulset/cassandra


