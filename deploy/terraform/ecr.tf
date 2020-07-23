# ECR for Rails app

resource "aws_ecr_repository" "ecr" {
  name = "${var.project}_app"  
}
