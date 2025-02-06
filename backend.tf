terraform {
  backend "s3" {
    bucket         = "my-terraform-backend-bucket-1436"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}