data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["vpc-0e7f8cc4da6772325"]
  }
}

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

data "aws_sns_topic" "my_sns_topic" {
  name = "my-sns-topic"
}

module "ecs_fargate_app" {
  source          = "./modules/ecs"
  vpc_id          = data.aws_vpc.main.id
  public_subnets  = data.aws_subnets.public.ids
  private_subnets = data.aws_subnets.private.ids
  app_name        = "challenge-app"
  desired_count   = 2
}

module "cloudwatch_alarms" {
  source           = "./modules/monitoring"
  app_name         = "challenge-app"
  cluster_name     = module.ecs_fargate_app.cluster_name
  service_name     = module.ecs_fargate_app.ecs_service_name
  cpu_threshold    = 80
  memory_threshold = 85
  alarm_actions    = [data.aws_sns_topic.my_sns_topic.arn]
}
