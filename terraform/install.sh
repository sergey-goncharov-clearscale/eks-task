#!/bin/bash

SERVICE_ACCOUNT="eks"
EKS_CLUSTER_NAME="eks-CSAWSCERT-210"
AWS_REGION="us-east-1"
AWS_PROFILE="sandbox"

aws eks --region ${AWS_REGION} --profile ${AWS_PROFILE} update-kubeconfig --name ${EKS_CLUSTER_NAME}

helm repo add eks https://aws.github.io/eks-charts
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set serviceAccount.name=${SERVICE_ACCOUNT} --set clusterName=${EKS_CLUSTER_NAME}
