# where to store the state
terraform {
  backend "s3" {
    bucket  = "tlkamp-infra-bucket"
    key     = "infrastructure/webservers/ubuntu-webserver.tfstate"
    encrypt = true
    region  = "us-east-2"
    profile = "webserver"
  }
}

# the provider configuration
provider "aws" {
  region  = "us-east-2"
  profile = "webserver"
}
