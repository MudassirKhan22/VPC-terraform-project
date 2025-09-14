# AWS Infrastructure with Terraform

## 🚀 Project Overview

This project demonstrates a complete AWS infrastructure setup using Terraform with a modular approach. It creates a highly available, scalable web application infrastructure in the AWS `ap-south-1` (Mumbai) region.

## 📋 Infrastructure Components

### 🏗️ **Core Infrastructure**
- **VPC (Virtual Private Cloud)** - Custom network with CIDR `10.0.0.0/16`
- **2 Public Subnets** - Multi-AZ deployment across `ap-south-1a` and `ap-south-1b`
- **Internet Gateway** - Enables internet access for public subnets
- **Route Tables** - Routes traffic to internet gateway
- **Network ACLs** - Additional security layer for subnets

### 🔒 **Security**
- **Security Groups** - Controls inbound/outbound traffic
  - SSH access (port 22) from anywhere
  - HTTP access (port 80) from anywhere
  - All outbound traffic allowed
- **Key Pairs** - SSH access to EC2 instances

### 💻 **Compute Resources**
- **2 EC2 Instances** with different configurations:
  - **Amazon Linux Instance** (`t2.micro`)
    - AMI: `ami-0b982602dbb32c5bd`
    - Volume: 8GB GP2
    - User Data: Installs Nginx and Docker
  - **Ubuntu Instance** (`t2.small`)
    - AMI: `ami-02d26659fd82cf299`
    - Volume: 12GB GP3
    - User Data: Installs Nginx and Docker

### ⚖️ **Load Balancing**
- **Application Load Balancer** - Distributes traffic across instances
- **Target Group** - Health checks and instance management
- **Listener** - HTTP traffic on port 80

### 🗄️ **Storage**
- **S3 Bucket** - Object storage with versioning enabled
- **EBS Volumes** - Persistent storage for EC2 instances

## 📁 Project Structure

```
Terraform-projects/
├── main.tf                    # Main configuration calling the module
├── provider.tf               # AWS provider configuration
├── terraform.tf              # Terraform version requirements
├── terraform.tfstate         # Terraform state file
├── terraform.tfstate.backup  # Backup state file
└── components/               # Module directory
    ├── vpc.tf               # VPC, subnets, IGW, route tables, NACL
    ├── ec2.tf               # EC2 instances, security groups, key pairs
    ├── elb.tf               # Load balancer, target group, listener
    ├── s3.tf                # S3 bucket and versioning
    ├── output.tf            # Output values
    ├── variable.tf          # Variable definitions
    ├── project              # Private SSH key
    ├── project.pub          # Public SSH key
    ├── test1.sh             # User data script for Amazon Linux
    └── test2.sh             # User data script for Ubuntu
```

## 🛠️ **Technologies Used**

- **Terraform** - Infrastructure as Code
- **AWS Provider** - Terraform AWS provider v6.11.0
- **Bash Scripting** - User data scripts for instance configuration
- **Nginx** - Web server
- **Docker** - Containerization platform

## 🚀 **Getting Started**

### Prerequisites

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** installed (version 1.0+)
3. **Git** for version control
4. **SSH Key Pair** (already included in the project)

### Git Setup (Important!)

Before starting, ensure you have a proper `.gitignore` file:

```bash
# The .gitignore file is already included in this project
# It prevents committing sensitive files like:
# - *.tfstate files (contain sensitive resource information)
# - *.tfvars files (may contain secrets)
# - .terraform/ directory (local cache)
```

**Never commit these files to version control:**
- `terraform.tfstate`
- `terraform.tfstate.backup`
- `*.tfvars` files
- `.terraform/` directory

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Terraform-projects
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review the plan**
   ```bash
   terraform plan
   ```

4. **Apply the configuration**
   ```bash
   terraform apply
   ```

5. **Access your infrastructure**
   - Get the load balancer DNS name from outputs
   - SSH to instances using the provided key pair

## 🔧 **Configuration Details**

### **VPC Configuration**
- **CIDR Block**: `10.0.0.0/16`
- **Subnets**: 
  - `10.0.1.0/24` in `ap-south-1a`
  - `10.0.2.0/24` in `ap-south-1b`
- **Availability Zones**: `ap-south-1a`, `ap-south-1b`

### **EC2 Instance Configuration**
- **Amazon Linux**: `t2.micro` with 8GB GP2 storage
- **Ubuntu**: `t2.small` with 12GB GP3 storage
- **Auto-assign Public IP**: Enabled
- **User Data**: Automated installation of Nginx and Docker

### **Load Balancer Configuration**
- **Type**: Application Load Balancer
- **Scheme**: Internet-facing
- **Health Check**: HTTP on port 80, path `/`
- **Target Group**: HTTP protocol on port 80

### **Security Configuration**
- **Security Group Rules**:
  - Inbound: SSH (22), HTTP (80)
  - Outbound: All traffic
- **Network ACL**: Allow all traffic (permissive for demo)

## 📊 **Outputs**

The infrastructure provides the following outputs:
- **VPC ID** - Virtual Private Cloud identifier
- **Instance Private DNS** - Private DNS names of EC2 instances
- **S3 Bucket Name** - Name of the created S3 bucket
- **Security Group ID** - Security group identifier
- **Security Group Name** - Security group name

## 🔍 **Key Features**

### **Modular Design**
- Clean separation of concerns
- Reusable components
- Easy maintenance and updates

### **High Availability**
- Multi-AZ deployment
- Load balancer for traffic distribution
- Health checks and auto-recovery

### **Security Best Practices**
- VPC isolation
- Security groups for access control
- SSH key-based authentication
- Network ACLs for additional security

### **Automation**
- Infrastructure as Code
- Automated instance configuration
- User data scripts for software installation

## 🚨 **Important Notes**

1. **Cost Management**: This setup creates billable AWS resources. Remember to destroy when not needed.

2. **Security**: The current configuration is set up for demonstration purposes. For production:
   - Restrict SSH access to specific IP ranges
   - Use more restrictive security group rules
   - Enable VPC Flow Logs for monitoring

3. **AMI Updates**: AMI IDs may become outdated. Update them regularly for security patches.

4. **State Management**: Consider using remote state storage (S3 + DynamoDB) for team collaboration.

5. **⚠️ State Files**: **NEVER commit Terraform state files to version control!**
   - State files contain sensitive information (resource IDs, sometimes secrets)
   - Use `.gitignore` to exclude `*.tfstate*` files
   - For team collaboration, use remote state storage (S3 + DynamoDB)
   - State files are local to your machine and should remain local

## 🧹 **Cleanup**

To destroy all resources:
```bash
terraform destroy
```

## 🔧 **Troubleshooting**

### Common Issues

1. **AMI Not Found**: Update AMI IDs in `main.tf` if they become unavailable
2. **Key Pair Issues**: Ensure the key pair exists in the target region
3. **S3 Bucket Name Conflicts**: Change the bucket name in `main.tf` if it already exists

### Useful Commands

```bash
# Check current state
terraform state list

# View specific resource
terraform state show <resource-address>

# Import existing resource
terraform import <resource-address> <resource-id>

# Refresh state
terraform refresh
```

## 📈 **Scaling Considerations**

This infrastructure can be easily scaled by:
- Adding more instances to the target group
- Implementing Auto Scaling Groups
- Adding more subnets across different AZs
- Implementing RDS for database needs
- Adding CloudFront for CDN

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 **License**

This project is for educational and demonstration purposes.

## 📞 **Support**

For issues and questions, please create an issue in the repository.

---

**Happy Infrastructure Building! 🚀**
