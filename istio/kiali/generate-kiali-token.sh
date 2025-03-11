#!/bin/bash

NEW_TOKEN=$(kubectl -n istio-system create token kiali)
# test