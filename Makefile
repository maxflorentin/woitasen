include .env
export $(shell sed 's/=.*//' .env)

.PHONY: all create-bucket enable-versioning create-dynamodb create-sns clean

all: create-bucket enable-versioning create-dynamodb create-sns

create-bucket:
	@echo "Creating S3 bucket: $(S3_BUCKET_NAME)"
	aws s3api create-bucket --bucket $(S3_BUCKET_NAME) --region $(AWS_REGION) --profile $(AWS_PROFILE)

enable-versioning:
	@echo "Enabling versioning on bucket: $(S3_BUCKET_NAME)"
	aws s3api put-bucket-versioning --bucket $(S3_BUCKET_NAME) --versioning-configuration Status=Enabled --profile $(AWS_PROFILE)

create-dynamodb:
	@echo "Creating DynamoDB table: $(DYNAMODB_TABLE_NAME)"
	aws dynamodb create-table \
		--table-name $(DYNAMODB_TABLE_NAME) \
		--attribute-definitions AttributeName=LockID,AttributeType=S \
		--key-schema AttributeName=LockID,KeyType=HASH \
		--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
		--region $(AWS_REGION) \
		--profile $(AWS_PROFILE)

create-sns:
	@echo "Creating SNS topic: $(SNS_TOPIC_NAME)"
	aws sns create-topic --name $(SNS_TOPIC_NAME) --profile $(AWS_PROFILE)

clean:
	@echo "Deleting resources..."
	
	@aws s3api head-bucket --bucket $(S3_BUCKET_NAME) --profile $(AWS_PROFILE) 2>/dev/null && \
	( \
		echo "Deleting S3 bucket: $(S3_BUCKET_NAME)"; \
		aws s3api delete-bucket --bucket $(S3_BUCKET_NAME) --profile $(AWS_PROFILE); \
	) || echo "S3 bucket $(S3_BUCKET_NAME) does not exist."

	@aws dynamodb describe-table --table-name $(DYNAMODB_TABLE_NAME) --profile $(AWS_PROFILE) 2>/dev/null && \
	( \
		echo "Deleting DynamoDB table: $(DYNAMODB_TABLE_NAME)"; \
		aws dynamodb delete-table --table-name $(DYNAMODB_TABLE_NAME) --profile $(AWS_PROFILE); \
	) || echo "DynamoDB table $(DYNAMODB_TABLE_NAME) does not exist."

	$(eval SNS_TOPIC_ARN=$(shell aws sns list-topics --query "Topics[?contains(TopicArn, '$(SNS_TOPIC_NAME)')].TopicArn | [0]" --output text --profile $(AWS_PROFILE)))
	@if [ "$(SNS_TOPIC_ARN)" != "None" ]; then \
		echo "Deleting SNS topic: $(SNS_TOPIC_NAME)"; \
		aws sns delete-topic --topic-arn $(SNS_TOPIC_ARN) --profile $(AWS_PROFILE); \
	else \
		echo "SNS topic $(SNS_TOPIC_NAME) does not exist."; \
	fi
