#!/bin/bash

# Add Helm Hashicorp
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

# Buat namespacenya dulu bro
namespace="vault"

if kubectl get namespace "${namespace}" >/dev/null 2>&1; then
   echo "Namespace '${namespace}' udah ada boy."
else
   kubectl create namespace "${namespace}"
   echo "Namespace '${namespace}' berhasil dibuat."
fi

#install Vault pake Helm biar ga bocor kepalanya
helm install vault hashicorp/vault \
   --set="server.dev.enabled=false" \
   --set="ui.enabled=true" \
   --set="ui.serviceType=ClusterIP" \
   --namespace "${namespace}"

helm install vault-secrets-operator hashicorp/vault-secrets-operator \
   --namespace "${namespace}"