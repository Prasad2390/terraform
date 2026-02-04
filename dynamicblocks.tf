provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "mysg" {
  name        = "sg1"
  description = "na"


  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "ports" {
  type    = list(any)
  default = ["22", "80", "8080", "9000"]
}
