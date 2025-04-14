#!/bin/bash

# Install Elastic Helm repo
echo "Menambahkan Elastic Helm repo..."
helm repo add elastic https://helm.elastic.co
helm repo update

# Create namespace
echo "Membuat namespace 'logging'..."
kubectl create namespace logging --dry-run=client -o yaml | kubectl apply -f -

# Install Elasticsearch
echo "📡  Menginstall Elasticsearch..."
helm install elasticsearch elastic/elasticsearch \
  --namespace logging \
  --set replicas=1 \
  --set minimumMasterNodes=1 \
  --set resources.requests.memory="1Gi" \
  --set resources.requests.cpu="500m"

# Install Kibana
echo "📊  Menginstall Kibana..."
helm install kibana elastic/kibana \
  --namespace logging \
  --set elasticsearchHosts=https://elasticsearch-master:9200 \
  --set resources.requests.memory="256Mi" \
  --set resources.requests.cpu="100m"

echo "✅  Elasticsearch dan Kibana sudah terinstall di namespace 'logging'."
echo "⚠️  Jangan lupa expose Kibana via Istio jika ingin akses dari browser."
