locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${local.cluster_name}"
KUBECONFIG

  eks_configmap = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks_node_group_iam_role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

# EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name = local.cluster_name
  role_arn = aws_iam_role.eks_iam_master_role.arn
  version = local.cluster_version

  vpc_config {
    security_group_ids = [aws_security_group.eks_cluster_master.id]
    subnet_ids = concat(aws_subnet.public_subnet.*.id, aws_subnet.private_subnet.*.id)
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy
  ]

  tags = {
    Name = local.cluster_name
  }
}


# EKS Node Group
resource "aws_eks_node_group" "eks_ng" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-ng"
  node_role_arn = aws_iam_role.eks_node_group_iam_role.arn
  subnet_ids = aws_subnet.private_subnet.*.id
  instance_types = ["t2.small"]

  scaling_config {
    desired_size = 1
    max_size = 2
    min_size = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_node_group_AmazonEC2ContainerRegistryReadOnly
  ]
}
