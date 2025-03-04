#!/bin/bash

# URL untuk file yaml Cert-Manager. cek berkala siapa tau ada yang lebih baru
CERT_MANAGER_URL="https://github.com/cert-manager/cert-manager/releases/download/v1.12.16/cert-manager.yaml"

# cek apakah kubectl sudah terinstal
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl tidak ditemukan. Silakan instal kubectl dulu coy."
    exit 1
fi

# konfigurasi Cert-Manager
echo "Menginstal Cert-Manager..."
kubectl apply -f "$CERT_MANAGER_URL"

# verif instalasi
echo "Menunggu semua pod Cert-Manager berjalan..."
kubectl wait --namespace cert-manager --for=condition=Ready pods --all --timeout=300s

echo "Cert-Manager berhasil diinstal."

# ini kalo lu mau pake SSL letsencrypt, kalo lu mau pake cloudflare ya gausah install ini