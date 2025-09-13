# 1. Create VPC
resource "aws_vpc" "new_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "New VPC"
    }
}

# 2. Create Subnet
resource "aws_subnet" "new_subnet1" {
    vpc_id = aws_vpc.new_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "New Subnet 1"
    }
}

resource "aws_subnet" "new_subnet2" {
    vpc_id = aws_vpc.new_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "New Subnet 2"
    }
}

# 3. Create Internet Gateway
resource "aws_internet_gateway" "new_igw" {
    vpc_id = aws_vpc.new_vpc.id

    tags = {
        Name = "New Internet Gateway"
    }
}

# 4. Create Route Table
resource "aws_route_table" "new_route_table" {
    vpc_id = aws_vpc.new_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.new_igw.id
    }

    tags = {
      Name = "New Route Table"
    }
}

# 5. Associate Subnets with Route Table
resource "aws_route_table_association" "new_subnet1_association" {
    subnet_id = aws_subnet.new_subnet1.id
    route_table_id = aws_route_table.new_route_table.id
}

resource "aws_route_table_association" "new_subnet2_association" {
    subnet_id = aws_subnet.new_subnet2.id
    route_table_id = aws_route_table.new_route_table.id
}

# 6. Create Network Access Control List
resource "aws_network_acl" "new_ncl" {
    vpc_id = aws_vpc.new_vpc.id

  # Inbound: allow all
  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # Outbound: allow all
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

    tags = {
      Name = "New NACL"
    }
}

# 7. Associate NACL with Subnets
resource "aws_network_acl_association" "nacl_to_subnet1_association" {
    network_acl_id = aws_network_acl.new_ncl.id
    subnet_id = aws_subnet.new_subnet1.id
}

resource "aws_network_acl_association" "nacl_to_subnet2_association" {
    network_acl_id = aws_network_acl.new_ncl.id
    subnet_id = aws_subnet.new_subnet2.id
}
