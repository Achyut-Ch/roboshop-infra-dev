terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }
  
  backend "s3" {
    bucket = "remote-state-aws-88ss1-dev"
    key    = "remote-dev-sg-rules" # this is on which name s3 bucket will be created
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }

}



provider "aws" {
  # Configuration options
  region = "us-east-1"
}