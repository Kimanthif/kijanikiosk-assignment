terraform {
  backend "s3" {
    bucket = "kijanistatefiles"
    key    = "state/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.region
}