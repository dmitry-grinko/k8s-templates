# k8s-templates

This repository contains various Kubernetes deployment templates for different environments and use cases. It includes configurations for Minikube, KIND, AWS EKS, Azure, and Google Cloud, along with advanced Kubernetes features and monitoring tools.

## Folder Structure

- [**minikube-basics**](./minikube-basics/) - Basic Kubernetes setup using Minikube. ✅
- [**kind-multi-node**](./kind-multi-node/) - Multi-node Kubernetes cluster using KIND.
- [**eks-deployment**](./eks-deployment/) - Deployment templates for AWS EKS.
- [**azure-deployment**](./azure-deployment/) - Deployment templates for Azure Kubernetes Service (AKS).
- [**gke-deployment**](./gke-deployment/) - Deployment templates for Google Kubernetes Engine (GKE).
- [**advanced-features**](./advanced-features/) - Advanced configurations such as HPA, Ingress, ConfigMaps, and Secrets.
- [**monitoring-logging**](./monitoring-logging/) - Monitoring and logging setup using Prometheus, Grafana, and ELK.

## How to Use

Each folder contains Kubernetes manifests (`deployment.yaml`, `service.yaml`, etc.) and a README file explaining the specific setup. You can modify and use these templates based on your needs.

