# 1. Create VPC
resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "New VPC"
  }
}

# 2. Create Subnet
resource "aws_subnet" "new_subnet" {
  vpc_id = aws_vpc.new_vpc.id
  for_each = {
    "new_subnet1" = {
      cidr_block        = var.subnet_cidr_block[0]
      availability_zone = var.availability_zones[0]
    }
    "new_subnet2" = {
      cidr_block        = var.subnet_cidr_block[1]
      availability_zone = var.availability_zones[1]
    }
  }
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
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
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_igw.id
  }

  tags = {
    Name = "New Route Table"
  }
}


# 5. Associate Subnets with Route Table
resource "aws_route_table_association" "new_subnet_association" {
  for_each       = aws_subnet.new_subnet
  subnet_id      = each.value.id
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
resource "aws_network_acl_association" "nacl_to_subnets_association" {
  for_each       = aws_subnet.new_subnet
  network_acl_id = aws_network_acl.new_ncl.id
  subnet_id      = each.value.id
}