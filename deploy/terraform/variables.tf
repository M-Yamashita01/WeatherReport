variable "region" {
  default = "ap-northeast-1"
}

variable "project" {
  default = "weatherreport"
}

variable "environment" {
  default = "prod"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "num_subnets" {
  default = 2
}

variable "key_name" {
  default = "your_key_name"
}

locals {
  base_tags = {
    Project     = "${var.project}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }

  default_tags    = "${merge(local.base_tags, map("kubernetes.io/cluster/${local.cluster_name}", "shared"))}"
  base_name       = "${var.project}-${var.environment}"
  cluster_name    = "${local.base_name}-cluster"
  cluster_version = "1.16"
}
