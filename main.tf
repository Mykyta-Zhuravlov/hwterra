provider "aws" {

  region = var.region

}


resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


data "aws_availability_zones" "available" {
  state = "available"
}
