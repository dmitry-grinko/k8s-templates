# Kubernetes Basics with Minikube

This project demonstrates basic Kubernetes concepts using a simple Node.js application deployed on Minikube.

## Prerequisites Installation

### 1. Docker
#### Ubuntu/Debian:
```bash
# Add Docker's official GPG key
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```bash
# Install Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add your user to docker group (requires logout/login to take effect)
sudo usermod -aG docker $USER
```

#### MacOS:
```bash
# Using Homebrew
brew install --cask docker
```




### 2. Minikube
#### Linux:
```bash
# Download the binary
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

#### MacOS:
```bash
# Using Homebrew
brew install minikube
```

### 3. kubectl
#### Linux:
```bash
# Download the binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

#### MacOS:
```bash
# Using Homebrew
brew install kubectl
```

### Verify Installation
```bash
# Verify Docker
docker --version

# Verify Minikube
minikube version

# Verify kubectl
kubectl version --client
```

## Project Structure
```bash
1-minikube-basics/
├── app/
│   ├── Dockerfile
│   ├── app.js
│   └── package.json
├── deployment.yaml
├── service.yaml
└── README.md
```

## Testing Locally with Docker
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

## Getting Started
```bash
1. Start Minikube:
   minikube start

2. Build the Docker image:
   # Point your shell to minikube's docker-daemon
   eval $(minikube -p minikube docker-env)
   
   # Build the image
   docker build -t k8s-test-app ./app

3. Deploy the application:
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml

4. Access the application:
   # Get the URL
   minikube service k8s-test-app --url
   
   # Or use port-forwarding
   kubectl port-forward service/k8s-test-app 3000:3000
```

## Cleanup
```bash
To clean up the resources:
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
minikube stop
```

## Troubleshooting

If you encounter permission issues with Docker:
```bash
# Add current user to docker group
sudo usermod -aG docker $USER

# Apply changes (or logout/login)
newgrp docker
```

If Minikube fails to start:
```bash
# Check if virtualization is enabled
egrep -c '(vmx|svm)' /proc/cpuinfo

# If using VirtualBox, ensure it's installed
sudo apt install virtualbox

# Start with specific driver
minikube start --driver=docker
```

## Additional Resources
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
