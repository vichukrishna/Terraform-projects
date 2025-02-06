provider "aws" {
  region = var.aws_region
}

#Get the workspace name dynamically

locals {
  workspace = terraform.workspace
}

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-${local.workspace}"

  tags = {
    environment = local.workspace
  }
}


