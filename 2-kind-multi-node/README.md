# Local Kubernetes Cluster Setup with Kind

This repository contains an application and Kubernetes configuration files for running it in a local Kubernetes cluster using Kind (Kubernetes in Docker).

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Installation

### macOS
Using Homebrew:

```bash
brew install kind
brew install kubectl
```

### Linux
Using curl to download Kind:

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

Install kubectl:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

### Windows
Using Chocolatey:

```bash
choco install kind
choco install kubernetes-cli
```

Or using Windows Package Manager:

```bash
winget install -e --id Kubernetes.kind
winget install -e --id Kubernetes.kubectl
```

## Testing Locally with Docker

Before deploying to Kind, you can test the application locally:

```bash
# Build the Docker image
docker build -t k8s-test-app ./app

# Run the container
docker run -d -p 3000:3000 --name k8s-test-app k8s-test-app

# Test the endpoint
curl http://localhost:3000

# Check container logs
docker logs k8s-test-app

# Stop and remove the container
docker stop k8s-test-app
docker rm k8s-test-app
```

## Setup

1. Create a local Kubernetes cluster:

```bash
kind create cluster --name my-cluster
```

2. Build and load the Docker image into Kind:
```bash
# Build the image
docker build -t k8s-test-app ./app

# Load the image into Kind
kind load docker-image k8s-test-app --name my-cluster
```

3. Verify the cluster is running:

```bash
kubectl cluster-info
```

4. Deploy the application and service:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

5. Verify the application and service are running:

```bash
kubectl get pods
kubectl get services
```

6. Access the application:
   - If using Kind, forward the port:
   ```bash
   kubectl port-forward service/k8s-test-app 3000:3000
   ```
   - Then visit http://localhost:3000 in your browser

## Cleanup

1. Delete the application and service:

```bash
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
```

2. Delete the cluster:

```bash
kind delete cluster --name my-cluster
```

## Notes

- The application is a simple Go application that prints "Hello, World!" to the console.
- The application is deployed using a Deployment resource with 3 replicas.
- The application is exposed using a NodePort Service on port 30000.
- For local development, port-forwarding is used to access the service.
- If you encounter an error like `unable to forward port because pod is not running. Current status=Pending`, this usually means:
  - The pods are still being created/scheduled
  - There might be issues pulling the container image
  - The cluster might not have enough resources
  You can check the pod status and logs using `kubectl get pods` and `kubectl describe pod <pod-name>` to diagnose the issue.
