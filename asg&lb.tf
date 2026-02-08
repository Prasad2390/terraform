resource "aws_launch_template" "mytmp" {
  name                   = "mytmp1"
  description            = "newone"
  image_id               = "ami-0532be01f26a3de55"
  instance_type          = "t3.micro"
  key_name               = "terra"
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum update -y 
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo chmod 766 /var/www/html/index.html
    sudo echo "<html><body><h1>Welcome to terraform</h1></body></html>" > /var/www/html/index.html
    sudo systemctl restart httpd
  EOF
  )
}



resource "aws_elb" "mylb" {
    name = "myelb"
    subnets = [aws_subnet.public_subnet.id, aws_subnet.public_subnet2.id]
     listener {
        instance_port = 80
        lb_port = 80
        lb_protocol = "http"
        instance_protocol = "http"
    }
}


resource "aws_autoscaling_group" "myasg" {
    name = "myasg"
    launch_template {
        id = aws_launch_template.mytmp.id
    }
    min_size = 2
    max_size = 4
    desired_capacity = 2
    vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.public_subnet2.id]
    load_balancers = [aws_elb.mylb.id]
}
