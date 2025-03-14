#!/bin/bash

# Update Helm Kiali
helm repo add kiali https://kiali.org/helm-charts
helm repo update

# Dir for Kiali config
KIALI_DIR="istio/kiali"

# Install Kiali
helm install kiali kiali/kiali-server \
  --namespace istio-system

# Wait until Kiali is ready
echo "Waiting for Kiali to be ready..."
for i in {1..30}; do  # Loop up to 30 times (around 3 minutes)
  STATUS=$(kubectl get pods -n istio-system -l app.kubernetes.io/name=kiali -o jsonpath='{.items[0].status.phase}')
  if [[ "$STATUS" == "Running" ]]; then
    echo "Kiali is running! Proceeding with custom configurations."
    break
  fi
  echo "Kiali is not ready yet. Retrying in 10 seconds..."
  sleep 10
done

# Apply custom Kiali configurations
kubectl apply -f $KIALI_DIR/rbac.yaml
kubectl apply -f $KIALI_DIR/kiali-values.yaml
kubectl apply -f $KIALI_DIR/kiali-deployment.yaml

echo "Kiali setup complete."
