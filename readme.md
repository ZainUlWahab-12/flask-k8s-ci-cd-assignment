# Flask Kubernetes CI/CD Application

A containerized Flask application with automated CI/CD pipeline using Jenkins and Kubernetes deployment orchestration.

## Project Overview

This project demonstrates a complete MLOps workflow featuring a simple Flask web application packaged with Docker, deployed on Kubernetes, and automated through a Jenkins CI/CD pipeline. The application includes a calculator module with unit tests to showcase testing integration in the deployment pipeline.

## Architecture

The application follows a modern microservices architecture:

* **Application Layer**: Flask web server providing REST API endpoints
* **Containerization**: Docker for consistent environment packaging
* **Orchestration**: Kubernetes for container management and scaling
* **CI/CD**: Jenkins pipeline for automated build and deployment
* **Testing**: Pytest framework for unit testing

## Project Structure

```
flask-k8s-ci-cd-assignment/
├── app.py                     Main Flask application
├── dockerfile                 Docker container configuration
├── jenkins                    Jenkins pipeline definition
├── requirements.txt           Python dependencies
├── mypackage/
│   ├── __init__.py           Package initialization
│   └── calculator.py         Calculator module
├── tests/
│   └── test_calculator.py    Unit tests
└── kubernetes/
    ├── deplopyment.yaml      Kubernetes deployment configuration
    └── service.yaml          Kubernetes service configuration
```

## Features

### Application Features

* REST API with health check endpoint
* Modular package structure
* Unit tested calculator module
* Containerized deployment ready

### DevOps Features

* Automated Docker image building
* Kubernetes deployment with 3 replicas
* Rolling update strategy for zero downtime
* Resource management with CPU and memory limits
* NodePort service for external access
* Jenkins pipeline automation

## Prerequisites

Before running this application, ensure you have the following installed:

* Python 3.11 or higher
* Docker
* Kubernetes cluster (Minikube, Docker Desktop, or cloud provider)
* kubectl CLI tool
* Jenkins (for CI/CD automation)

## Installation

### Local Development Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd flask-k8s-ci-cd-assignment
```

2. Install Python dependencies:
```bash
pip install -r requirements.txt
```

3. Run the application locally:
```bash
python app.py
```

The application will be accessible at `http://localhost:5000`

### Docker Setup

1. Build the Docker image:
```bash
docker build -t my-app-image:latest .
```

2. Run the container:
```bash
docker run -p 5000:5000 my-app-image:latest
```

### Kubernetes Deployment

1. Apply the Kubernetes manifests:
```bash
kubectl apply -f kubernetes/
```

2. Verify the deployment:
```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

3. Access the application:
```bash
kubectl get svc flask-app-service
```

The service is exposed on NodePort 30080. Access it at `http://<node-ip>:30080`

## API Endpoints

### GET /

Returns a simple greeting message.

**Response:**
```
Hello, World!
```

### GET /health

Health check endpoint returning application status.

**Response:**
```json
{
  "status": "ok"
}
```

## Testing

Run the unit tests using pytest:

```bash
pytest tests/
```

Run tests with verbose output:

```bash
pytest -v tests/
```

## CI/CD Pipeline

The Jenkins pipeline automates the following stages:

### Stage 1: Build Docker Image

Builds a Docker image from the Dockerfile using the tag `my-app-image:latest`.

### Stage 2: Deploy to Kubernetes

Applies all Kubernetes manifests from the `kubernetes/` directory to deploy the application.

### Stage 3: Verify Deployment

Performs verification checks:
* Checks deployment rollout status
* Lists running pods
* Verifies service configuration

### Pipeline Configuration

The pipeline uses the following environment variables:

* `IMAGE_NAME`: Docker image name and tag (my-app-image:latest)
* `KUBE_MANIFEST_DIR`: Directory containing Kubernetes manifests (kubernetes)

## Kubernetes Configuration

### Deployment Specifications

* **Replicas**: 3 pods for high availability
* **Strategy**: RollingUpdate with maxSurge: 1, maxUnavailable: 1
* **Container Port**: 5000
* **Resource Requests**: CPU 100m, Memory 128Mi
* **Resource Limits**: CPU 300m, Memory 256Mi
* **Image Pull Policy**: Never (uses local images)

### Service Specifications

* **Type**: NodePort for external access
* **Service Port**: 5000
* **Target Port**: 5000
* **Node Port**: 30080 (fixed port for consistent access)

## Dependencies

The application requires the following Python packages:

* **Flask**: Web framework for building the REST API
* **pytest**: Testing framework for unit tests
* **flake8**: Code linting and style checking

## Development Workflow

1. Make code changes in your local environment
2. Run unit tests to verify functionality
3. Commit changes to version control
4. Jenkins pipeline automatically triggers
5. Pipeline builds Docker image
6. Pipeline deploys to Kubernetes cluster
7. Deployment verification ensures successful rollout

## Troubleshooting

### Application Not Starting

Check the pod logs:
```bash
kubectl logs -l app=flask-app
```

### Deployment Issues

Describe the deployment:
```bash
kubectl describe deployment flask-app
```

### Service Not Accessible

Verify the service endpoints:
```bash
kubectl get endpoints flask-app-service
```

### Docker Build Failures

Ensure all dependencies are listed in requirements.txt and the Dockerfile syntax is correct.

## Best Practices Implemented

* Containerization for environment consistency
* Infrastructure as Code with Kubernetes manifests
* Automated testing in development workflow
* Rolling updates for zero downtime deployments
* Resource limits for predictable performance
* Health check endpoints for monitoring
* Declarative Jenkins pipeline configuration

## Scaling

Scale the application by adjusting the replica count:

```bash
kubectl scale deployment flask-app --replicas=5
```

Or modify the `replicas` field in `kubernetes/deplopyment.yaml` and reapply:

```bash
kubectl apply -f kubernetes/deplopyment.yaml
```

## Monitoring

Check application status:

```bash
kubectl get pods -l app=flask-app -w
```

View resource usage:

```bash
kubectl top pods -l app=flask-app
```

## Contributing

When contributing to this project:

1. Write unit tests for new functionality
2. Ensure all tests pass before committing
3. Follow PEP 8 style guidelines (enforced by flake8)
4. Update documentation for new features
5. Test Docker builds locally before pushing

## License

This project is created for educational purposes as part of MLOps coursework.

## Author

ZainUlWahab-12

Fardeen-cmyk

i220476-creator

## Acknowledgments

This project demonstrates modern DevOps practices including containerization, orchestration, and continuous integration/deployment for machine learning operations.