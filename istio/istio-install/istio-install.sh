#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Function to install Istio with default profile
function install_istio() {
    echo "Installing Istio with default profile..."
    istioctl install --set profile=default -y
}

# Execute installation
install_istio

echo "Istio installation completed successfully."
