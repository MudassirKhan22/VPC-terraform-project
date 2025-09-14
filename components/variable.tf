# Variable definitions for VPC and Subnets
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "List of CIDR block for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

# Variable definitions for EC2 Instances, key pair and Security Groups
variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
  default     = "project.pub"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instances"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = list(string)
}

variable "volumes" {
  description = "Volume configuration per instance"
  type = list(object({
    size = number
    type = string
  }))
  default = [
    { size = 8, type = "gp2" },
    { size = 16, type = "gp3" }
  ]
}


# Variable definitions for S3 Bucket
variable "S3" {
  description = "Value for S3 bucket"
  type        = string
}

# Variable definitions for ELB
variable "elb" {
  description = "ELB Configuration"
  type = object({
    name               = string
    internal           = bool
    load_balancer_type = string
    subnets            = list(string)
    security_groups    = list(string)
  })
}

# Variable definitions for Target Group
variable "target_group" {
  description = "Target Group Configuration"
  type = object({
    name     = string
    port     = number
    protocol = string
  })
}

# Variable definitions Listener
variable "listener" {
  description = "Listener Configuration"
  type = object({
    port     = number
    protocol = string
  })
}