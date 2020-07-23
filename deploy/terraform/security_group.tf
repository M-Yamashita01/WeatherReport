# Security Group
resource "aws_security_group" "eks_cluster_master" {
  name = "cluster-master"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "${var.project}-eks-cluster-master"
  }
}

resource "aws_security_group" "eks_cluster_nodes" {
  name = "cluster-nodes"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow cluster master to access cluster nodes"
    from_port = 1025
    to_port = 65535
    protocol = "tcp"

    security_groups = [aws_security_group.eks_cluster_master.id]
  }

  ingress {
    description = "Allow cluster master to access cluster nodes"
    from_port = 1025
    to_port = 65535
    protocol = "udp"

    security_groups = [aws_security_group.eks_cluster_master.id]
  }

  ingress {
    description = "Allow inter pods communication"
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "${var.project}-eks-cluster-nodes"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    security_groups = [aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id]
  }

  tags = {
    Name = "sg-${var.project}-rds"
  }
}

# Security Group for VPC Endpoint to pull image from ECR
resource "aws_security_group" "vpc-endpoint" {
  name = "vpc-endpoint-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow access to ECR from EKS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow access to ECR from EKS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
}
