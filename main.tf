#Nothing sensitive will be  found in this file


provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "ami-0c7217cdde317cfec" # Replace this with your AMI
  subnet_id = "subnet-0cf60929eb83bfdd2" # Replace this with Subnet Info
  tags = {
    name = "Webserver"
    Description = "An nginx webserver on Ubuntu"
  }

  user_data = <<-EOF
                        #!/bin/bash
                        sudo apt update
                        sudo apt install nginx -y
                        systemctl enable nginx
                        systemctl start  nginx
                        EOF
key_name = aws_key_pair.web.id
vpc_security_group_ids = [aws_security_group.ssh_access.id] #This expects a list, thus the square bracket
}

resource "aws_key_pair" "web" {
  public_key = file("/home/.ssh/web.pub") #Replace this with  your  pem key (This key is in your local machine  where terraform is running)
}

resource "aws_security_group" "ssh_access" {
  name = "ssh_access"
  description = "Allow ssh access"
  ingress = {
    from_port = 22
    to_port  = 22
    protocol = "tcp"
    cidr_block =  ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "aws_instance_webserver.public_ip" #We will use this ip  later to ssh to the machine
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "sample-bucket-2024" # Replace this with you bucket name
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
