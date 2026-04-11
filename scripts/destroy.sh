#!/bin/bash
set -e

echo "==> Destroying TaskApp infrastructure"
echo "==> WARNING: This will delete everything!"
echo ""

read -p "Are you sure? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

# Delete Kubernetes resources
echo "[1/3] Deleting Kubernetes resources..."
kubectl delete -k k8s/overlays/production/ --ignore-not-found
kubectl delete -k k8s/base/ --ignore-not-found

# Delete Kops cluster
echo "[2/3] Deleting Kops cluster..."
kops delete cluster --name=taskapp.durotoluwa-tasked.com --yes

# Destroy Terraform resources
echo "[3/3] Destroying Terraform resources..."
cd terraform/environments/prod
terraform destroy -auto-approve

echo ""
echo "✅ Everything destroyed successfully!"
