## Requirements

### Infrastructure with Terraform

Use Terraform to create a modular setup.
Implement remote state with S3 and DynamoDB for state locking.

### ECS and Load Balancing

Deploy a containerized web app (e.g., NGINX) on ECS Fargate.
Configure auto-scaling for the ECS tasks (min 1, max 3).
Use an Application Load Balancer (ALB) for traffic distribution.

### Networking and Security

Set up a VPC with public/private subnets across multiple AZs.
Use security groups to allow only HTTP/HTTPS traffic from the ALB.
Configure IAM roles for ECS tasks with least privilege permissions.

### Optional (Bonus): Monitoring and Alarms

Set up basic CloudWatch alarms for ECS (e.g., CPU and memory).

## Instructions

### Create .env file, you can base on .env.example

```bash
AWS_PROFILE=default
S3_BUCKET_NAME=woitasem-tf-state-bucket
DYNAMODB_TABLE_NAME=terraform-lock-table
SNS_TOPIC_NAME=my-sns-topic
AWS_REGION=us-east-1
```

### Run makefile

```bash
make clean
make all
```

### Run terraform commands

```bash
terraform init
terraform plan
terraform apply
```

That is! Now you have a running ECS cluster on your AWS account.
