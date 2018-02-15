#!/bin/bash
set -e

BASEDIR=$(cd "$(dirname "$0")" && pwd)
BIN="$BASEDIR/bin"
YAML="$BASEDIR/yaml"

cd $BASEDIR/vagrant/
vagrant up

echo "Waiting for Kubernetes API..."
until curl --silent --insecure "https://172.17.4.101:443"
do
    sleep 5
done

$BIN/k create -f $YAML/cassandra/svc.yml
$BIN/k create -f $YAML/cassandra/vol.yml
$BIN/k create -f $YAML/cassandra/stateful.yml
$BIN/k scale --replicas=3 statefulset/cassandra

$BIN/k create ns prometheus
$BIN/h install coreos/kube-prometheus --namespace prometheus --name monitoring
 
