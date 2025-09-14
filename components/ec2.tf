# 1. Create key pair
resource "aws_key_pair" "new_key_pair" {
  key_name   = var.key_pair_name
  public_key = file("${path.module}/${var.key_pair_name}")
}

# 1. Create a Security Group
resource "aws_security_group" "new_sg" {
  name   = "new_security_group"
  vpc_id = aws_vpc.new_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "New Security Group"
  }
}


# 2. Create EC2 Instances
resource "aws_instance" "new_ec2_instance" {
  for_each = {
    "amazon-linux-instance" = {
      ami           = var.instance_ami[0]
      instance_type = var.instance_type[0]
      subnet_key    = "new_subnet1"
      user_data     = file("${path.module}/test1.sh")
      volume_index  = 0
    },
    "ubuntu-instance" = {
      ami           = var.instance_ami[1]
      instance_type = var.instance_type[1]
      subnet_key    = "new_subnet2"
      user_data     = file("${path.module}/test2.sh")
      volume_index  = 1
    }
  }

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.new_subnet[each.value.subnet_key].id
  key_name                    = aws_key_pair.new_key_pair.key_name
  security_groups             = [aws_security_group.new_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.volumes[each.value.volume_index].size
    volume_type           = var.volumes[each.value.volume_index].type
    delete_on_termination = true
}


  user_data = each.value.user_data

  tags = {
    Name = each.key
  }
}