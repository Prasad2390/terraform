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



------creating multiple resources---
resource "aws_instance" "myec2" {
  tags = {
    Name = var.iname[count.index]
    ENv  = "prod"
  }
  ami                    = "ami-0532be01f26a3de55"
  instance_type          = var.itype ? "t3.micro" : "t3.small"
  key_name               = "personal"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  root_block_device {
    volume_size = var.volume
  }
  count = 2
}

variable "iname" {
  type    = list(string)
  default = ["myfirst", "second"]
}
variable "itype" {
  type    = bool
  default = true
}
variable "volume" {
  type    = number
  default = 20
}

terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-aaprove
terraform validate
terraform fmt
terraform state list
terraform destroy --auto-approve -target="...."
terraform taint "...."    -----to recreate the resorce
terraform apply --auto-approve
terraform apply --auto-approve -replace="...." ----to recreate the resource
terraform refresh
