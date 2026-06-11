# 🛍️ ShopFlow – Production-Ready E-Commerce Platform on AWS

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

**ShopFlow** is a fully automated, cloud-native e-commerce platform deployed on AWS. It leverages Infrastructure as Code (Terraform), containerization (Docker), and a CI/CD pipeline (GitHub Actions) to achieve zero-touch deployments from code push to production.

> 🚀 **Live demo**: [http://shopflow-alb-1290382372.eu-west-1.elb.amazonaws.com](http://shopflow-alb-1290382372.eu-west-1.elb.amazonaws.com)

---

## 📐 Architecture Overview
User → ALB (public) → Auto Scaling Group (EC2) → Docker Container (nginx)
↓
RDS MySQL (private)
↓
CloudWatch (monitoring + alerts)

text

- **Networking**: VPC with public & private subnets across 2 Availability Zones (eu-west-1a & 1b)
- **Compute**: Auto Scaling Group (min 2, max 3) using Launch Template – runs Dockerized app
- **Database**: Managed MySQL (RDS) in private subnets, accessible only by app servers
- **CI/CD**: GitHub Action builds Docker image → pushes to ECR → terraform apply → rolling update via instance refresh
- **Monitoring**: CloudWatch dashboard + CPU alarm sends email via SNS

📁 **Full Terraform modules**: VPC, IAM, EC2, RDS, Monitoring

---

## 🛠️ Technologies Used

| Category       | Tools                                                                 |
|----------------|-----------------------------------------------------------------------|
| Cloud Provider | AWS (EC2, RDS, VPC, IAM, ECR, S3, CloudWatch, SNS, ALB, NAT Gateway) |
| IaC            | Terraform (remote state via S3 + locking)                            |
| Container      | Docker, nginx:alpine, ECR                                            |
| CI/CD          | GitHub Actions (OIDC-ready, concurrency control, manual approval)    |
| Monitoring     | CloudWatch Dashboard + Alarms + SNS email notifications               |

---


