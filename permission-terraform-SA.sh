#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

PROJECT_ID="eighth-strata-454614-d5"
SERVICE_ACCOUNT="hin-terraform@$PROJECT_ID.iam.gserviceaccount.com"
KEY_FILE="terraform-key.json"

# Function to add IAM policy binding
function add_iam_role() {
    local ROLE="$1"
    echo "Assigning role: $ROLE to $SERVICE_ACCOUNT"
    gcloud projects add-iam-policy-binding "$PROJECT_ID" \
        --member="serviceAccount:$SERVICE_ACCOUNT" \
        --role="$ROLE"
}

# Assign necessary IAM roles
add_iam_role "roles/compute.admin"
add_iam_role "roles/iam.serviceAccountAdmin"
add_iam_role "roles/resourcemanager.projectIamAdmin"
add_iam_role "roles/container.admin"
add_iam_role "roles/iam.serviceAccountUser"

# Create service account key
echo "Generating service account key file: $KEY_FILE"
gcloud iam service-accounts keys create "$KEY_FILE" --iam-account="$SERVICE_ACCOUNT"

echo "IAM setup completed successfully."
