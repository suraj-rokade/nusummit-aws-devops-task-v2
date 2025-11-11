resource "aws_instance" "web_server" {
  ami                         = "ami-03ca05b225b1434e0" # Amazon Linux 2023 x86_64
  instance_type               = "t4g.micro"
  subnet_id                   = data.aws_subnet.existing_subnet.id
  vpc_security_group_ids      = [data.aws_security_group.existing_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_codedeploy_profile.name


  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y ruby wget httpd
    systemctl start httpd
    systemctl enable httpd

    # Install CodeDeploy agent
    cd /home/ec2-user
    wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
    chmod +x ./install
    ./install auto

    systemctl enable codedeploy-agent
    systemctl start codedeploy-agent

    # Deploy initial index.html
    cat <<'HTML' > /var/www/html/index.html
    ${file("../app/index.html")}
    HTML
    EOF


  tags = {
    Name = "web-server"
  }
}


