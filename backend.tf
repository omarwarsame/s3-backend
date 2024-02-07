#Nothing sensitive will be  found in this file
terraform {
  backend "s3" {
    bucket         = "sample-bucket-2024" # change this to you bucket name
    key            = "omarwarsame/terraform.tfstate"
    region         = "us-east-1"
      encrypt        = true
      dynamodb_table = "terraform-lock"
  }
}
