provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "ap-south-1"
  alias  = "mumbai"
}

resource "aws_instance" "myserver" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  tags = {
    Name = "nv-server"
  }
}

resource "aws_instance" "myserver2" {
  provider      = "aws.mumbai"
  ami           = "ami-0ff5003538b60d5ec"
  instance_type = "t3.micro"
  tags = {
    Name = "mumbai-server"
  }
}

output "abc" {
  value = [aws_instance.myserver.public_ip, aws_instance.myserver.privat_ip]
