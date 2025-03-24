#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

NAMESPACE="monitoring"

# Function to install Prometheus with Helm
function install_grafana() {
    echo "Installing Grafana with Helm..."
    helm install grafana bitnami/grafana -n "$NAMESPACE"
}

# Ensure namespace exists
if kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
   echo "Namespace '$NAMESPACE' udah ada cuy."
else
   kubectl create namespace "$NAMESPACE"
   echo "Namespace '$NAMESPACE' udah dibuat nih."
fi

# Execute installation
install_grafana

echo "Grafana installation completed successfully."
echo "User: admin"
echo "Password: $(kubectl get secret grafana-admin --namespace monitoring -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 -d)"

# Grafana.com dashboard id list:
# Dashboard	ID
# k8s-addons-prometheus.json	   | 19105
# k8s-addons-trivy-operator.json | 16337
# k8s-system-api-server.json	   | 15761
# k8s-system-coredns.json	      | 15762
# k8s-views-global.json	         | 15757
# k8s-views-namespaces.json	   | 15758
# k8s-views-nodes.json	         | 15759
# k8s-views-pods.json	         | 15760
