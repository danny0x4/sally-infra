#!/bin/bash
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update

# Buat namespacenya dulu bro
namespace="cattle-system"
if kubectl get namespace "${namespace}" >/dev/null 2>&1; then
    echo "Namespace '${namespace}' udah ada boy."
else
    kubectl create namespace "${namespace}"
    echo "Namespace '${namespace}' berhasil dibuat."
fi

# Install rancher
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.sallystore.my.id \
  --set bootstrapPassword=admin