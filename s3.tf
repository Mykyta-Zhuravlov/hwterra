terraform {

  backend "s3" {

    profile = "terraform"
    bucket  = "hwterra"
    key     = "hwterra/terraform.tfstate"
    region  = "eu-west-1"

  }
}