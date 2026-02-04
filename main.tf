resource "aws_instance" "myec2" {
  tags = {
    Name = var.iname
    ENv  = "prod"
  }
  ami                    = "ami-0532be01f26a3de55"
  instance_type          = var.itype ? "t3.micro" : "t3.small"
  key_name               = "personal"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  root_block_device {
    volume_size = var.volume
  }
}

variable "iname" {
  type    = string
  default = "myfirst"
}
variable "itype" {
  type    = bool
  default = true
}
variable "volume" {
  type    = number
  default = 20
}
