#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

NAMESPACE="argocd"
ARGOCD_VERSION="v2.14.7"

# Function to check if a namespace exists
function create_namespace() {
    if ! kubectl get namespace "$NAMESPACE" &>/dev/null; then
        echo "Creating namespace: $NAMESPACE"
        kubectl create namespace "$NAMESPACE"
    else
        echo "Namespace $NAMESPACE already exists"
    fi
}

# Function to apply ArgoCD manifests
function install_argocd() {
    echo "Applying ArgoCD manifests..."
    kubectl apply -n "$NAMESPACE" -f "https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/install.yaml"
    kubectl apply -n "$NAMESPACE" -f "https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/ha/install.yaml" # disable if you don't need that
}

# Function to get the initial admin password

# Function to patch ArgoCD for Istio & domain exposure
function patch_argocd_config() {
    echo "Patching ArgoCD configuration..."
    kubectl patch configmap argocd-cmd-params-cm -n "$NAMESPACE" --type merge -p '{"data":{"server.insecure":"true"}}'
}

# Function to restart ArgoCD server deployment
function restart_argocd_server() {
    echo "Restarting ArgoCD server..."
    kubectl rollout restart deployment argocd-server -n "$NAMESPACE"
}

function get_admin_password() {
    echo "Retrieving ArgoCD admin password..."
    sleep 30
    kubectl get secret argocd-initial-admin-secret -n "$NAMESPACE" -o jsonpath="{.data.password}" | base64 --decode
    echo ""
}

# Main Execution
create_namespace
install_argocd
kubectl get pods -n "$NAMESPACE"
get_admin_password
patch_argocd_config
restart_argocd_server

echo "ArgoCD setup completed successfully."
