#!/bin/bash

# Install Elastic Helm repo
echo "Adding Elastic Helm repo..."
helm repo add elastic https://helm.elastic.co
helm repo update

# Create namespace
echo "Create namespace 'logging'..."
kubectl create namespace logging

# Install Elasticsearch
echo "Installing Elasticsearch..."
helm install elasticsearch elastic/elasticsearch \
  --namespace logging \
  --set replicas=1 \
  --set minimumMasterNodes=1 \
  --set resources.requests.memory="1Gi" \
  --set resources.requests.cpu="500m"

# Install Kibana
echo "Installing Kibana..."
helm install kibana elastic/kibana \
  --namespace logging \
  --set elasticsearchHosts=https://elasticsearch-master:9200 \
  --set resources.requests.memory="256Mi" \
  --set resources.requests.cpu="100m"

echo "✅ Elasticsearch and Kibana has installed in 'logging' namespace."
echo "⚠️ Don't forget to expose Kibana via Istio if want to accessed from browser."
