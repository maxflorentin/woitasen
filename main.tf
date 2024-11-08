data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["vpc-0e7f8cc4da6772325"]
  }
}

# data.tf del root module
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["public-*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["private-*"]
  }
}

module "ecs_fargate_app" {
  source          = "./modules/ecs"
  vpc_id          = data.aws_vpc.main.id
  public_subnets  = data.aws_subnets.public.ids
  private_subnets = data.aws_subnets.private.ids
  app_name        = "challenge-app"
  desired_count   = 2
}
