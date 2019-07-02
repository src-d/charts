#!/bin/bash

set -e

CHANGED_FILES=$(mktemp)
trap "rm -f $CHANGED_FILES" EXIT

git diff --name-only "$TRAVIS_COMMIT_RANGE" > "$CHANGED_FILES"

grep 'Chart.yaml$' "$CHANGED_FILES" || { echo "No Chart.yaml files changed. No need to hate Kubernetes. Exiting."; exit 0; }

curl -Lo kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl"
sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin/
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 
sudo chmod +x minikube && sudo mv minikube /usr/local/bin/
sudo minikube start --vm-driver=none --kubernetes-version="${KUBERNETES_VERSION}"
sudo chown -R travis /home/travis/.minikube/
minikube update-context

# wait till node is ready
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'; until kubectl get nodes -o jsonpath="$JSONPATH" 2>&1 | grep -q "Ready=True"; do sleep 1; done

helm init
# wait till the tiller is ready
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'; until kubectl get pods -n kube-system -l name=tiller -o jsonpath="$JSONPATH" 2>&1 | grep -q "Ready=True"; do sleep 1; done
