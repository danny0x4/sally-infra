#!/bin/bash

# Namespace dan nama deployment Istio Ingress Gateway
NAMESPACE="istio-system"
DEPLOYMENT="istio-ingressgateway"

# Patch deployment untuk mengatur numTrustedProxies dan forwardClientCertDetails
kubectl patch deployment "${DEPLOYMENT}" -n "${NAMESPACE}" -p '{"spec":{"template":{"metadata":{"annotations":{"proxy.istio.io/config":"{\"gatewayTopology\":{\"numTrustedProxies\": 1,\"forwardClientCertDetails\":\"SANITIZE_SET\"}}"}}}}}'

# Cek status deployment setelah patching
kubectl rollout status deployment "${DEPLOYMENT}" -n "${NAMESPACE}"

# jalankan ini dulu sebelum apply envoyfilter