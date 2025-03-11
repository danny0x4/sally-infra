#!/bin/bash

NEW_TOKEN=$(kubectl -n istio-system create token kiali)

# update token di vault
vault kv put kv-v2/data/kiali/token token=$NEW_TOKEN

echo "Token berhasil di update!"