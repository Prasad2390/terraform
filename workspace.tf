provider "aws" {
  region = "us-east-1"
}

locals {
  instance_types = {
    dev = "t3.micro"
    test = "t3.small"
  }
}
resource "aws_instance" "server1" {
  tags = {
    Name = "${terraform.workspace}"
  }
  ami           = "ami-0532be01f26a3de55"
  instance_type = local.instance_types[terraform.workspace]
}
---------

terraform workspace new dev
terrraform worskapce select dev
terraform workspace delete dev
terraform workspace list
terraform state list 
