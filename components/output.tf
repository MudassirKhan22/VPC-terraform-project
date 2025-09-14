output "instance_public_ip" {
  description = "Public IP addresses of the EC2 instances"
  value       = { for id, instance in aws_instance.new_ec2_instance : id => instance.public_ip }
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instances"
  value       = { for id, instance in aws_instance.new_ec2_instance : id => instance.public_dns }
}

output "instance_private_ip" {
  description = "Private IP addresses of the EC2 instances"
  value       = { for id, instance in aws_instance.new_ec2_instance : id => instance.private_ip }
}

output "instance_private_dns" {
  description = "Private DNS of the EC2 instances"
  value       = { for id, instance in aws_instance.new_ec2_instance : id => instance.private_dns }
}

output "s3_bucket" {
  description = "S3 bucket names"
  value       = aws_s3_bucket.new_bucket.bucket
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.new_vpc.id
}

output "subnet_ids" {
  description = "Subnet IDs"
  value       = { for id, subnet in aws_subnet.new_subnet : id => subnet.id }
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.new_sg.id
}

output "security_group_name" {
  description = "Security Group Name"
  value       = aws_security_group.new_sg.name
}

output "load_balancer_dns" {
  description = "DNS of the Load Balancer"
  value       = aws_lb.new_lb.dns_name
}