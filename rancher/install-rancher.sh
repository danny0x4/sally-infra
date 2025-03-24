#!/bin/bash
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update

# Buat namespacenya dulu bro
RANCHER_HOSTNAME="rancher.sallystore.my.id"
BOOTSTRAP_SECRET="bootstrap-secret"
NAMESPACE="cattle-system"

if kubectl get namespace "${NAMESPACE}" >/dev/null 2>&1; then
    echo "Namespace '${NAMESPACE}' udah ada boy."
else
    kubectl create namespace "${NAMESPACE}"
    echo "Namespace '${NAMESPACE}' berhasil dibuat."
fi

# Install rancher
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.sallystore.my.id \
  --set bootstrapPassword=admin

# Get Rancher setup URL
SETUP_TOKEN=$(kubectl get secret --namespace "$NAMESPACE" "$BOOTSTRAP_SECRET" -o go-template='{{.data.bootstrapPassword|base64decode}}')
echo "To get started with Rancher, visit the following URL:"
echo "https://$RANCHER_HOSTNAME/dashboard/?setup=$SETUP_TOKEN"

# Retrieve only the bootstrap password
echo "To retrieve the bootstrap password, run:"
echo "kubectl get secret --namespace $NAMESPACE $BOOTSTRAP_SECRET -o go-template='{{.data.bootstrapPassword|base64decode}}{{ \"\\n\" }}'"

echo "Rancher installation completed successfully."