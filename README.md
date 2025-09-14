<img width="3840" height="1695" alt="Untitled diagram _ Mermaid Chart-2025-09-14-184338" src="https://github.com/user-attachments/assets/fb23d3db-705a-4655-b035-0d83a7786aa3" />


# 🚀 AWS Infrastructure with Terraform - Complete 3-Tier Architecture

A comprehensive AWS infrastructure project built with Terraform, featuring a complete 3-tier architecture with web servers, load balancer, and RDS database in private subnets.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Infrastructure Components](#infrastructure-components)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Key Features](#key-features)
- [Important Notes](#important-notes)
- [Git Setup](#git-setup)
- [Architecture Diagram](#architecture-diagram)
- [Usage](#usage)
- [Monitoring and Management](#monitoring-and-management)
- [Cleanup](#cleanup)
- [Troubleshooting](#troubleshooting)

## 🎯 Project Overview

This project demonstrates a production-ready AWS infrastructure using Terraform, implementing a complete 3-tier architecture with:

- **Web Tier**: EC2 instances behind an Application Load Balancer
- **Application Tier**: Load balancer with health checks and target groups
- **Database Tier**: RDS MySQL database in private subnets
- **Networking**: VPC with public and private subnets, NAT Gateway, and security groups

## 🏗️ Architecture

### High-Level Architecture
```
Internet → ALB → EC2 Instances (Public Subnets)
                    ↓
              RDS Database (Private Subnets)
                    ↓
              NAT Gateway (for outbound access)
```

### Network Design
- **VPC**: 10.0.0.0/16
- **Public Subnets**: 10.0.1.0/24, 10.0.2.0/24 (for web servers)
- **Private Subnets**: 10.0.10.0/24, 10.0.20.0/24 (for RDS database)
- **Multi-AZ**: Deployed across ap-south-1a and ap-south-1b

## 🛠️ Infrastructure Components

### **Networking (VPC)**
- ✅ VPC with DNS support
- ✅ 2 Public Subnets (for web servers)
- ✅ 2 Private Subnets (for RDS database)
- ✅ Internet Gateway (for public access)
- ✅ NAT Gateway (for private subnet outbound access)
- ✅ Route Tables (public and private)
- ✅ Network ACLs

### **Compute (EC2)**
- ✅ 2 EC2 Instances:
  - Amazon Linux 2 (t2.micro)
  - Ubuntu 20.04 (t2.small)
- ✅ Key Pair for SSH access
- ✅ Security Groups (SSH:22, HTTP:80)
- ✅ EBS Volumes (8GB gp2, 12GB gp3)
- ✅ User Data Scripts (Nginx + Docker installation)

### **Load Balancing**
- ✅ Application Load Balancer
- ✅ Target Group with Health Checks
- ✅ Load Balancer Listener (HTTP:80)

### **Database (RDS)**
- ✅ MySQL 8.0 Database (db.t3.micro)
- ✅ RDS Subnet Group (Multi-AZ)
- ✅ RDS Security Group (MySQL:3306)
- ✅ Automated Backups (7 days retention)
- ✅ Storage Encryption enabled
- ✅ Private subnet deployment

### **Storage**
- ✅ S3 Bucket with Versioning
- ✅ EBS Volumes for EC2 instances

### **Security**
- ✅ Security Groups (Web and RDS)
- ✅ Network ACLs
- ✅ Private database access only
- ✅ Encrypted storage

## 📁 Project Structure

```
Terraform-projects/
├── main.tf                    # Root module configuration
├── provider.tf               # AWS provider configuration
├── terraform.tf              # Terraform settings
├── components/               # Terraform module
│   ├── vpc.tf               # VPC, subnets, IGW, NAT Gateway
│   ├── ec2.tf               # EC2 instances and security groups
│   ├── elb.tf               # Load balancer and target groups
│   ├── rds.tf               # RDS database and security groups
│   ├── s3.tf                # S3 bucket configuration
│   ├── variable.tf          # Input variables
│   └── output.tf            # Output values
├── architecture-with-rds.mmd # Architecture diagram (Mermaid)
├── linkedin-post.md         # LinkedIn post options
├── .gitignore              # Git ignore file
└── README.md               # This file
```

## 🔧 Prerequisites

- **Terraform** (>= 1.0)
- **AWS CLI** configured with appropriate credentials
- **Git** for version control
- **AWS Account** with appropriate permissions

### Required AWS Permissions
- EC2 (instances, security groups, key pairs, VPC)
- RDS (database instances, subnet groups, parameter groups)
- ELB (load balancers, target groups)
- S3 (bucket creation and management)
- IAM (if using roles)

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone <your-repo-url>
cd Terraform-projects
```

### 2. Configure AWS Credentials
```bash
aws configure
# Enter your Access Key ID, Secret Access Key, and region (ap-south-1)
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Review the Plan
```bash
terraform plan
```

### 5. Deploy the Infrastructure
```bash
terraform apply
```

### 6. Access Your Infrastructure
```bash
# Get load balancer DNS name
terraform output load_balancer_dns

# Get RDS endpoint
terraform output rds_endpoint
```

## ✨ Key Features

### **High Availability**
- Multi-AZ deployment across 2 availability zones
- Load balancer with health checks
- RDS database with automated backups

### **Security**
- Database isolated in private subnets
- Security groups with least privilege access
- Network ACLs for additional security layer
- Encrypted storage and database

### **Scalability**
- Load balancer distributes traffic
- Auto-scaling ready architecture
- Modular Terraform design for easy scaling

### **Automation**
- Infrastructure as Code with Terraform
- Automated instance configuration
- Automated software installation

### **Monitoring**
- Load balancer health checks
- RDS monitoring and logging
- CloudWatch integration ready

## ⚠️ Important Notes

### **State Management**
- **NEVER commit `.tfstate` files to version control**
- State files contain sensitive information
- Use remote state storage for team collaboration
- Consider using Terraform Cloud or S3 backend

### **Cost Management**
- This infrastructure uses free tier eligible resources
- Monitor your AWS bill regularly
- Use `terraform destroy` to clean up resources

### **Security Considerations**
- Change default passwords
- Use IAM roles instead of access keys when possible
- Enable MFA for AWS accounts
- Regular security updates

## 🔐 Git Setup

### Create .gitignore
```bash
# Terraform
*.tfstate
*.tfstate.backup
*.tfvars
*.tfvars.json
.terraform/
.terraform.lock.hcl
crash.log
crash.*.log

# AWS
.aws/

# Keys
project*
*.pem
*.key

# OS
.DS_Store
Thumbs.db
```

### Initialize Git Repository
```bash
git init
git add .
git commit -m "Initial commit: AWS Infrastructure with Terraform"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

## 📊 Architecture Diagram

The project includes a Mermaid architecture diagram (`architecture-with-rds.mmd`) showing:

- VPC with public and private subnets
- Internet Gateway and NAT Gateway
- Application Load Balancer
- EC2 instances in public subnets
- RDS database in private subnets
- Security groups and network flow

To view the diagram:
1. Copy the content from `architecture-with-rds.mmd`
2. Paste it into [Mermaid Live Editor](https://mermaid.live/)
3. Or use any Mermaid-compatible viewer

## 💻 Usage

### Accessing Web Servers
```bash
# Get load balancer DNS
terraform output load_balancer_dns

# Access via browser
http://<load-balancer-dns>
```

### Connecting to RDS Database
```bash
# Get RDS endpoint
terraform output rds_endpoint

# Connect from EC2 instance (in private subnet)
mysql -h <rds-endpoint> -u admin -p
```

### SSH to EC2 Instances
```bash
# Get instance public IPs
terraform output instance_public_ips

# SSH to instances
ssh -i project.pem ec2-user@<public-ip>  # Amazon Linux
ssh -i project.pem ubuntu@<public-ip>    # Ubuntu
```

## 📈 Monitoring and Management

### Check Infrastructure Status
```bash
# View all resources
terraform state list

# Check specific resource
terraform state show aws_instance.new_ec2_instance

# View outputs
terraform output
```

### AWS Console
- **EC2**: View instances and security groups
- **RDS**: Monitor database performance
- **ELB**: Check load balancer health
- **VPC**: Review network configuration
- **S3**: Manage bucket contents

## 🧹 Cleanup

### Destroy All Resources
```bash
terraform destroy
```

### Verify Cleanup
```bash
# Check AWS console to ensure all resources are deleted
# Verify no unexpected charges on your AWS bill
```

## 🔧 Troubleshooting

### Common Issues

1. **Terraform State Lock**
   ```bash
   terraform force-unlock <lock-id>
   ```

2. **AWS Credentials**
   ```bash
   aws sts get-caller-identity
   ```

3. **Resource Already Exists**
   - Check AWS console for existing resources
   - Import existing resources or use different names

4. **Permission Denied**
   - Verify AWS IAM permissions
   - Check security group rules

### Getting Help
- Check Terraform documentation
- Review AWS service documentation
- Check project issues and discussions

## 📝 License

This project is for educational purposes. Please ensure you comply with AWS terms of service and your organization's policies.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For questions or issues:
- Create an issue in the repository
- Check the troubleshooting section
- Review AWS and Terraform documentation

---

**Happy Infrastructure Building! 🚀**

*Built with ❤️ using Terraform and AWS*
