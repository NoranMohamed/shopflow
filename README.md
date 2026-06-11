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

## 🚀 Deployment Guide

### Phase 0 – One‑time Bootstrap (manual)

> These resources cannot be created by Terraform because Terraform needs them to store state and push images.

```bash
# Create S3 bucket for Terraform state (must be globally unique)
aws s3api create-bucket --bucket shopflow-terraform-<yourname> --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1
aws s3api put-bucket-versioning --bucket shopflow-terraform-<yourname> --versioning-configuration Status=Enabled

# Create ECR repository
aws ecr create-repository --repository-name shopflow --region eu-west-1

# Export Account ID & ECR URI
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export ECR_URI=$AWS_ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/shopflow
Phase 1 – Deploy Infrastructure
bash
cd terraform
terraform init
terraform plan -var="ecr_image_uri=${ECR_URI}:latest" -var="db_password=YourStrongPass123!" -out=tfplan
terraform apply tfplan
Phase 2 – Build & Push Docker Image
bash
cd ../app
docker build -t shopflow .
docker tag shopflow:latest ${ECR_URI}:latest
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin ${ECR_URI}
docker push ${ECR_URI}:latest
Phase 3 – Refresh EC2 Instances
bash
aws autoscaling start-instance-refresh --auto-scaling-group-name shopflow-asg --region eu-west-1
After 2‑3 minutes, visit the app_url output – you should see the ShopFlow homepage.

🔁 CI/CD Pipeline (GitHub Actions)
The pipeline is triggered on every push to main:

Build & Push – builds Docker image, pushes to ECR

Terraform Plan – generates an execution plan

Manual Approval – waits for approval (production environment)

Terraform Apply – applies the saved plan

Smoke Test – curls the ALB endpoint to verify deployment

🔐 Security note: The pipeline uses OIDC (recommended) or long‑lived keys. For production, switch to AWS OIDC to avoid static credentials.

🧹 Cleanup
To avoid ongoing costs, destroy all resources when not needed:

bash
cd terraform
terraform destroy -var="ecr_image_uri=${ECR_URI}:latest" -var="db_password=YourStrongPass123!"
Also manually delete the S3 bucket (after emptying it) and the ECR repository if no longer required.

📊 Monitoring & Alerts
Dashboard: AWS Console → CloudWatch → Dashboards → shopflow-dashboard

Alerts: SNS email subscription – you will receive an email when CPU > 70% for 2 consecutive periods (every 2 minutes)

Logs: Container logs are sent to CloudWatch Log Group /shopflow/app

🤝 Contributing
Contributions are welcome! Please open an issue or submit a pull request.

📝 License
This project is licensed under the MIT License – see the LICENSE file for details.

👩‍💻 Author
Noran Mohamed
GitHub

🙏 Acknowledgements
AWS free tier for learning & experimentation

HashiCorp Terraform documentation

Docker community
