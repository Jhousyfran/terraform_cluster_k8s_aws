terraform {
  required_providers {
    aws = ">=4.19"
    local = ">=2.2.3"
  }
}

provider "aws" {
  region = "us-east-1"
}