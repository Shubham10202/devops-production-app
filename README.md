# DevOps Production App 🚀

A hands-on end-to-end DevOps project demonstrating **Linux, Git, Docker, Terraform, AWS, GitHub Actions, GHCR, IAM OIDC, AWS Systems Manager, and automated CI/CD deployment**.

## 🏗️ Architecture

```text
Developer
   │
   │ git push
   ▼
GitHub Repository
   │
   ├──────────────► GitHub Actions CI
   │                    │
   │                    ├── Terraform fmt
   │                    ├── Terraform validate
   │                    ├── Terraform plan
   │                    ├── Python syntax check
   │                    ├── Docker build
   │                    ├── Container health test
   │                    └── Push image to GHCR
   │
   ▼
Successful CI on main
   │
   ▼
GitHub Actions CD
   │
   │ GitHub OIDC
   ▼
AWS IAM
   │
   ▼
AWS Systems Manager
   │
   ▼
EC2 Ubuntu Server
   │
   ├── Docker
   │     │
   │     └── devops-app container
   │             │
   │             └── GHCR image
   │
   ▼
Application
Port 80 → Container Port 8080
```

## 🛠️ Technologies

- Linux / Ubuntu
- Git & GitHub
- GitHub Actions
- Docker
- Docker Compose
- GitHub Container Registry (GHCR)
- Terraform
- AWS EC2
- AWS IAM
- AWS Systems Manager / Session Manager
- AWS S3 Terraform Remote State
- Python
- Shell scripting

## 📁 Project Structure

```text
devops-production-app/
│
├── app/
│   └── app.py
│
├── logs/
│
├── scripts/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── data.tf
│   ├── backend.tf
│   ├── terraform-ci.tfvars.example
│   └── modules/
│       └── ec2/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── cd.yml
│
├── Dockerfile
├── compose.yaml
├── .gitignore
└── README.md
```

## 🐳 Docker

The application is packaged as a Docker image.

The container:

- Runs Python application
- Exposes port `8080`
- Uses environment variables
- Creates a logs directory
- Supports health checks
- Uses restart policy for production-style operation

Example:

```bash
docker build -t devops-production-app .
```

Run locally:

```bash
docker run -d \
  --name devops-app \
  -p 8080:8080 \
  -e APP_ENV=production \
  -e APP_PORT=8080 \
  devops-production-app
```

Health check:

```bash
curl http://localhost:8080/health
```

Expected:

```text
Application is healthy
```

## ☁️ Terraform

Terraform manages the AWS infrastructure.

The project uses:

- AWS provider
- EC2
- Security Group
- Terraform module
- Variables
- Outputs
- Existing VPC data source
- S3 remote state
- S3 native state locking

Terraform state is stored remotely in an encrypted S3 backend.

Terraform validation and planning are also executed automatically in GitHub Actions.

## 🔐 AWS Authentication

GitHub Actions does not use long-lived AWS access keys for CI/CD deployment.

Instead, the project uses:

**GitHub Actions OIDC → AWS IAM Role**

This provides temporary AWS credentials and removes the need to store AWS access keys in GitHub Secrets.

The deployment workflow uses AWS Systems Manager to communicate with EC2.

## 🔄 CI Pipeline

The CI workflow runs on pushes to `main` and pull requests targeting `main`.

The CI pipeline performs:

1. Checkout repository
2. Setup Terraform
3. Terraform format check
4. Terraform initialization
5. Terraform validation
6. Terraform plan
7. Python syntax validation
8. Docker image build
9. Start test container
10. Application health check
11. Login to GHCR
12. Push `latest` image
13. Push commit-SHA image
14. Cleanup test container

## 🚀 CD Pipeline

A successful CI workflow triggers the deployment workflow.

The CD pipeline:

1. Receives successful CI `workflow_run`
2. Confirms the CI run belongs to `main`
3. Authenticates to AWS using GitHub OIDC
4. Sends an AWS Systems Manager command to EC2
5. Pulls the latest Docker image from GHCR
6. Removes the previous container
7. Starts the new container
8. Waits for application startup
9. Runs the production health check
10. Reports deployment success or failure

## 🏥 Application Health

The application provides:

### Health endpoint

```text
GET /health
```

Response:

```text
Application is healthy
```

### Application endpoint

```text
GET /
```

Response:

```text
Hello from DevOps Production App
```

## 📊 Production Deployment

The production application runs on:

```text
AWS EC2
Ubuntu
Docker
Port 80 → Container Port 8080
```

The production container is pulled from:

```text
ghcr.io/shubham10202/devops-production-app
```

## 🔒 Security Practices

This project demonstrates several security practices:

- GitHub OIDC instead of permanent AWS credentials
- IAM roles for GitHub Actions
- SSM Session Manager instead of public SSH administration
- SSH ingress removed from the production Security Group
- Terraform state stored remotely in S3
- S3 public access blocked
- Terraform state encryption enabled
- Deployment restricted to successful `main` CI runs
- CI publishes both `latest` and immutable Git commit-SHA Docker image tags

## ✅ Final Validation

The final deployment was successfully validated with:

```bash
sudo docker ps
```

The production container was running from the GHCR image.

Health check:

```bash
curl http://localhost/health
```

Response:

```text
Application is healthy
```

Application:

```bash
curl http://localhost/
```

Response:

```text
Hello from DevOps Production App
```

## 🎯 What This Project Demonstrates

This project demonstrates practical experience with:

- Linux administration
- Git workflows
- Docker containerization
- Docker image management
- CI/CD automation
- Infrastructure as Code
- Terraform modules
- Terraform remote state
- AWS EC2
- AWS IAM
- GitHub OIDC
- AWS Systems Manager
- Container Registry
- Application health checks
- Production-style deployment automation
- Troubleshooting failed CI/CD deployments

## 💼 Interview Summary

> Built an end-to-end DevOps CI/CD pipeline using GitHub Actions, Terraform, Docker, GHCR and AWS. Terraform manages the AWS infrastructure with remote state stored in S3. GitHub Actions uses OIDC for temporary AWS authentication. On every push to the main branch, CI validates Terraform, builds and tests the Docker image, and publishes it to GHCR. A successful CI workflow triggers CD, which uses AWS Systems Manager to deploy the latest image to an EC2 instance, replace the running container and perform an application health check.

## 📌 Future Improvements

Potential next improvements include:

- Add centralized logging
- Add CloudWatch monitoring and alarms
- Add application metrics
- Add Terraform apply with manual approval
- Add staging and production environments
- Add blue/green or rolling deployments
- Add automated rollback
- Add vulnerability scanning for Docker images
- Add Terraform security scanning
- Add Kubernetes deployment
- Add monitoring with Prometheus and Grafana
