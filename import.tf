provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "server1" {
  tags = {
    Name = "manual"
  }
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
}


terraform import aws_instance.server1 i-0212b1bc7f1130332


