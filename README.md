# Terraform AWS Webserver Deployment

This Terraform configuration automates the deployment of an Nginx web server on an AWS EC2 instance running Ubuntu. It also sets up necessary networking resources, an S3 bucket, and a DynamoDB table for state locking.

## Prerequisites

- An AWS account with appropriate permissions.
- Terraform installed on your local machine.

## Usage

1. Clone this repository to your local machine.
2. Navigate to the directory containing the Terraform code.
3. Update the variables in the `main.tf` file as per your requirements:
   - Replace `ami`, `subnet_id`, and `public_key` with appropriate values.
   - Specify the desired bucket name for the S3 backend in both `main.tf` and `terraform.tf` files.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform plan` to review the planned changes.
6. Run `terraform apply` to apply the Terraform configuration and provision the AWS resources.
7. Once provisioning is complete, the public IP address of the EC2 instance will be displayed as output.

## Terraform Resources

### AWS EC2 Instance

- Instance Type: t2.micro
- AMI: Ubuntu (Replace with desired AMI)
- Tags:
  - Name: Webserver
  - Description: An Nginx webserver on Ubuntu
- User Data: Installs Nginx and starts the service upon instance launch.

### AWS Key Pair

- Used for SSH access to the EC2 instance.

### AWS Security Group

- Name: ssh_access
- Description: Allows SSH access from any IP address.

### AWS S3 Bucket

- Bucket Name: sample-bucket-2024 (Replace with desired bucket name)

### AWS DynamoDB Table

- Name: terraform-lock
- Billing Mode: PAY_PER_REQUEST
- Hash Key: LockID (String type)

## Terraform Backend Configuration

The Terraform configuration uses an S3 backend for storing state files. It's configured with the following settings:

This is for the S3 backend (on a separate file)
terraform {
  backend "s3" {
    bucket         = "sample-bucket-2024" # Replace this with your bucket name
    key            = "omarwarsame/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}



Cleaning Up
When you're finished with the resources, remember to run terraform destroy to remove them and avoid incurring unnecessary costs.
