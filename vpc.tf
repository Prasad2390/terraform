provider "aws" {
region = "us-east-1"
}




resource "aws_vpc" "myvpc" {
tags = {
Name = "Terraform-VPC"
}
cidr_block = "12.0.0.0/16"
instance_tenancy = "default"
enable_dns_hostnames = true
}


resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.myvpc.id
tags = {
Name = "Terraform-Public-SN"
}
availability_zone = "us-east-1a"
cidr_block = "12.0.0.0/24"
map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
vpc_id = aws_vpc.myvpc.id
tags = {
Name = "Terraform-Private-SN"
}
availability_zone = "us-east-1a"
cidr_block = "12.0.1.0/24"
}


resource "aws_internet_gateway" "myigw" {
tags = {
Name = "Terraform-IGW"
}
vpc_id = aws_vpc.myvpc.id
}


resource "aws_route_table" "public_rt" {
tags = {
Name = "Terraform-Public-RT"
}
vpc_id = aws_vpc.myvpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.myigw.id
}
}


resource "aws_route_table" "private_rt" {
tags = {
Name = "Terraform-Private-RT"
}
vpc_id = aws_vpc.myvpc.id
route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.mynat.id
}
}


resource "aws_route_table_association" "public_association" {
subnet_id = aws_subnet.public_subnet.id
route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
subnet_id = aws_subnet.private_subnet.id
route_table_id = aws_route_table.private_rt.id
}


resource "aws_security_group" "public-sg" {
name = "public-sg"
description = "this is for public-sn"
vpc_id = aws_vpc.myvpc.id

ingress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "private-sg" {
name = "private-sg"
description = "this is for private-sn"
vpc_id = aws_vpc.myvpc.id

ingress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}


resource "aws_eip" "myeip" {
domain = "vpc"
}
resource "aws_nat_gateway" "mynat" {
tags = {
Name = "terraform-nat"
}
subnet_id = aws_subnet.public_subnet.id
allocation_id = aws_eip.myeip.id
}
