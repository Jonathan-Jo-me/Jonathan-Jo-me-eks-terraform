terraform {
  backend "s3" {
    bucket         = "terraform-statefile-s3bucket-eks"
    key            = "backend/TFSTATE-FILE.tfstate"
    region         = "ap-south-1"
    #dynamodb_table = "Dynamodb-terraform"
  }
}
