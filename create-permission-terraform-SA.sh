#!/bin/bash
set -e

PROJECT_ID="mesmerizing-air-457914-p4"
SERVICE_ACCOUNT="bay-terraform@$PROJECT_ID.iam.gserviceaccount.com"
KEY_FILE="terraform-key.json"

# Create the service account if it doesn't exist
if ! gcloud iam service-accounts list --filter="email=$SERVICE_ACCOUNT" --format="value(email)" | grep -q "$SERVICE_ACCOUNT"; then
    echo "Creating service account: $SERVICE_ACCOUNT"
    gcloud iam service-accounts create "bay-terraform" \
        --display-name "Terraform Provisioning Service Account"
else
    echo "Service account already exists: $SERVICE_ACCOUNT"
fi

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
