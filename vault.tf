provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = var.mytoken
}

variable "mytoken" {
  type        = string
  description = "na"
  sensitive   = "true"
}


provider "aws" {
  region     = "us-east-1"
  access_key = data.vault_generic_secret.aws.data["access_key"]
  secret_key = data.vault_generic_secret.aws.data["secret_key"]
}

data "vault_generic_secret" "aws" {
  path = "secret/aws"
}
