terraform {
  backend "s3" {
    bucket         = "devops-terraform-project-1"
    key            = "env/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}