data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

# Subnet
resource "aws_subnet" "public_subnet" {
  count = var.num_subnets
  vpc_id = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[ count.index % var.num_subnets ]
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-public-subnet-${count.index+1}"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.num_subnets
  vpc_id = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[ count.index % var.num_subnets ]
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, var.num_subnets + count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-private-subnet-${count.index+1}"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

# Elastic IP
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "${var.project}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public_subnet.0.id

  tags = {
    Name = "${var.project}-nat"
  }
}


# Route table
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-public-id"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project}-private-id"
  }
}

# Route table associationn
resource "aws_route_table_association" "rtba_public" {
  count = var.num_subnets
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "rtba_private" {
  count = var.num_subnets
  subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_vpc_endpoint" "endpoint-ecr-api-public" {
  service_name = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type = "Interface"
  vpc_id = aws_vpc.vpc.id
  subnet_ids = aws_subnet.public_subnet.*.id
  security_group_ids = [aws_security_group.vpc-endpoint.id]

  tags = {
    Name = "${var.project}-endpoint-ecr-api-public"
  }
}

resource "aws_vpc_endpoint" "endpoint-ecr-api-private" {
  service_name = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type = "Interface"
  vpc_id = aws_vpc.vpc.id
  subnet_ids = aws_subnet.private_subnet.*.id
  security_group_ids = [aws_security_group.vpc-endpoint.id]

  tags = {
    Name = "${var.project}-endpoint-ecr-api-private"
  }
}

resource "aws_vpc_endpoint" "endpoint-ecr-dkr-public" {
  service_name = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  vpc_id = aws_vpc.vpc.id
  subnet_ids = aws_subnet.public_subnet.*.id
  security_group_ids = [aws_security_group.vpc-endpoint.id]

  tags = {
    Name = "${var.project}-endpoint-ecr-dkr-public"
  }
}

resource "aws_vpc_endpoint" "endpoint-ecr-dkr-private" {
  service_name = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  vpc_id = aws_vpc.vpc.id
  subnet_ids = aws_subnet.private_subnet.*.id
  security_group_ids = [aws_security_group.vpc-endpoint.id]

  tags = {
    Name = "${var.project}-endpoint-ecr-dkr-private"
  }
}