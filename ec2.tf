# 1. Create key pair
resource "aws_key_pair" "new_key_pair" {
    key_name = "project"
    public_key = file("project.pub")
}


# 1. Create a Security Group
resource "aws_security_group" "new_sg" {
    name = "new_security_group"
    vpc_id = aws_vpc.new_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "New Security Group"
    }
}


# 2. Create EC2 Instances
resource "aws_instance" "new_ec2_instance1" {
    ami = "ami-0861f4e788f5069dd"  # Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"
    key_name = aws_key_pair.new_key_pair.key_name
    subnet_id = aws_subnet.new_subnet1.id
    security_groups = [aws_security_group.new_sg.id]
    associate_public_ip_address = true

    root_block_device {
      volume_size = 8
      volume_type = "gp2"
      delete_on_termination = true
    }

    user_data_base64  = base64encode(file("test1.sh"))

    tags = {
      Name = "New EC2 Instance"
    }
}


resource "aws_instance" "new_ec2_instance2" {
    ami = "ami-0861f4e788f5069dd"  # Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"
    key_name = aws_key_pair.new_key_pair.key_name
    subnet_id = aws_subnet.new_subnet2.id
    security_groups = [aws_security_group.new_sg.id]
    associate_public_ip_address = true

    root_block_device {
      volume_size = 8
      volume_type = "gp2"
      delete_on_termination = true
    }

    user_data_base64  = base64encode(file("test2.sh"))

    tags = {
      Name = "New EC2 Instance"
    }
}