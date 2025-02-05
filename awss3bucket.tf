provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "my-terraform-state-bucket-12345"
    force_destroy = true  
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
      status = "Enabled"
    }
  
}
resource "aws_dynamodb_table" "terraform_locks" {
  name="terraform-locks"
  billing_mode = "PAY PER REQUEST"
  hash_key = "LockID"

  attribute {
    name="LockID"
    type = "S"
  }
}
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-12345"
    key = "terraform-tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
    
  }
}
resource "aws_instance" "skoda" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
tags={
    name="terraform-instance"
}  
}