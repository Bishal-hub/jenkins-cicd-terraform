terraform {
  backend "s3" {
    bucket         = "terraform-state-s3-bishal-bucket"
    key            = "ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table-bishal"
    encrypt        = true
  }
}