#!/bin/bash

set -euo pipefail

echo "🔍 Extracting EKS cluster info from Terraform outputs..."
CLUSTER_NAME=$(terraform output -raw eks_cluster_name)
AWS_REGION=$(terraform output -raw aws_region)
ARN=$(terraform output -raw current_arn)

echo "✅ Cluster: $CLUSTER_NAME"
echo "✅ Region: $AWS_REGION"
echo "✅ Current ARN: $ARN"

echo "🔧 Updating kubeconfig for kubectl access..."
aws eks update-kubeconfig --name "$CLUSTER_NAME" --region "$AWS_REGION"

echo "🚀 Applying RBAC resources to the cluster..."
kubectl apply -f sdm-rbac.yaml

echo "✅ Done! Resources deployed to EKS cluster: $CLUSTER_NAME"