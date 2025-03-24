#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

NAMESPACE="monitoring"

# Function to install Prometheus with Helm
function install_prometheus() {
    echo "Installing Prometheus with Helm..."
    helm install prometheus prometheus-community/prometheus -n "$NAMESPACE"
}

# Ensure namespace exists
if kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
   echo "Namespace '$NAMESPACE' udah ada cuy."
else
   kubectl create namespace "$NAMESPACE"
   echo "Namespace '$NAMESPACE' udah dibuat nih."
fi

# Execute installation
install_prometheus

echo "Prometheus installation completed successfully."
