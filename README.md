# 🛍️ ShopFlow – Production-Ready E-Commerce Platform on AWS

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge\&logo=amazon-aws\&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge\&logo=terraform\&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?style=for-the-badge\&logo=docker\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-%232671E5.svg?style=for-the-badge\&logo=githubactions\&logoColor=white)

[![ShopFlow Deploy](https://github.com/NoranMohamed/shopflow/actions/workflows/deploy.yml/badge.svg)](https://github.com/NoranMohamed/shopflow/actions/workflows/deploy.yml)

## 📖 Overview

ShopFlow is a cloud-native e-commerce platform deployed on AWS using Infrastructure as Code (Terraform), Docker containerization, and GitHub Actions CI/CD.

The platform is designed following production-ready cloud architecture principles, including high availability, automated deployments, monitoring, and scalable infrastructure.


---

## 🏗️ Architecture Diagram


<img width="1415" height="784" alt="diagram-export-6-11-2026-9_35_45-PM" src="https://github.com/user-attachments/assets/4a275f9b-ce47-40bf-8fe1-9c2203989d56" />

---

## ✨ Key Features

* Infrastructure as Code using Terraform Modules
* Multi-AZ AWS Architecture
* Public and Private Subnets
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Dockerized Application Deployment
* Amazon ECR Container Registry
* Amazon RDS MySQL Database
* CloudWatch Monitoring & Dashboards
* SNS Email Notifications
* GitHub Actions CI/CD Pipeline
* Terraform Remote State in S3
* High Availability & Scalability

---

## ☁️ AWS Services Used

| Category         | Services                |
| ---------------- | ----------------------- |
| Compute          | EC2, Auto Scaling Group |
| Networking       | VPC, ALB, NAT Gateway   |
| Database         | Amazon RDS MySQL        |
| Containerization | Docker                  |
| Registry         | Amazon ECR              |
| Monitoring       | CloudWatch              |
| Notifications    | SNS                     |
| Storage          | Amazon S3               |
| IAM              | IAM Roles & Policies    |
| CI/CD            | GitHub Actions          |
| IaC              | Terraform               |

---

## 📂 Project Structure

```text
shopflow/
│
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
│
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── ec2/
│   │   ├── rds/
│   │   ├── iam/
│   │   └── monitoring/
│   │
│   ├── backend.tf
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
└── README.md
```

---

## 🚀 Deployment Workflow

### 1. Provision Infrastructure

```bash
cd terraform

terraform init
terraform plan
terraform apply
```

### 2. Build & Push Docker Image

```bash
docker build -t shopflow .

docker tag shopflow:latest <ECR_URI>:latest

docker push <ECR_URI>:latest
```

### 3. Deploy Application

```bash
aws autoscaling start-instance-refresh \
--auto-scaling-group-name shopflow-asg
```

---

## 🔁 CI/CD Pipeline

The GitHub Actions workflow automates the deployment process:

1. Build Docker Image
2. Push Image to Amazon ECR
3. Terraform Plan
4. Manual Approval
5. Terraform Apply
6. Smoke Testing
7. Instance Refresh

```text
Git Push
   │
   ▼
GitHub Actions
   │
   ▼
Build Docker Image
   │
   ▼
Push to ECR
   │
   ▼
Terraform Plan
   │
   ▼
Manual Approval
   │
   ▼
Terraform Apply
   │
   ▼
Smoke Test
   │
   ▼
Production Deployment
```

---

## 📊 Monitoring & Alerting

### CloudWatch Dashboard

Monitored Metrics:

* EC2 CPU Utilization
* Auto Scaling Health
* Network Traffic
* RDS Performance

### SNS Notifications

Email alerts are triggered when:

* CPU utilization exceeds configured thresholds
* Infrastructure health issues occur
* Monitoring alarms are activated

---

## 🔐 Security Highlights

* Private Application Subnets
* Private Database Subnets
* Security Groups with least-privilege access
* IAM Roles for AWS Services
* No hardcoded secrets
* GitHub Secrets for sensitive variables
* Terraform Remote State in Amazon S3

---

## 📈 Scalability & High Availability

* Multi-AZ deployment
* Application Load Balancer
* Auto Scaling Group
* Stateless Docker containers
* Managed Amazon RDS service

---

## 🧹 Cleanup

```bash
cd terraform

terraform destroy
```

---

## 👩‍💻 Author

**Noran Mohamed**

* Cloud Architecture Engineer
* ITI Cloud Architecture Graduate
* Electronics & Communications Engineering Graduate

GitHub: https://github.com/NoranMohamed

LinkedIn: https://www.linkedin.com/in/noran-mohamed

---

## 📜 License

This project is licensed under the MIT License.
