data "aws_ami" "ubuntu-ami" {
  # Canonical
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  most_recent = true
}

locals {
  ami_in_use    = "ami-0653e888ec96eab9b"
  ipv4_anywhere = "0.0.0.0/0"
  ipv6_anywhere = "::/0"
}

output "server-up-to-date" {
  value = data.aws_ami.ubuntu-ami.image_id == local.ami_in_use
}

resource "aws_instance" "ubuntu-web" {
  ami           = local.ami_in_use
  instance_type = "t2.micro"
  key_name      = "udacity-webserver"

  tags = {
    Name = "Ubuntu Web"
  }
}

resource "aws_eip" "ubuntu-web-static-ip" {
  instance = aws_instance.ubuntu-web.id
  vpc      = true
}

resource "aws_security_group" "ubuntu-web-sg" {
  description = "launch-wizard-6 created 2019-01-20T17:06:25.634-06:00"
}

resource "aws_security_group_rule" "ubuntu-web-sg" {
  cidr_blocks       = [local.ipv4_anywhere]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 80
  type              = "ingress"
}

resource "aws_security_group_rule" "ubuntu-web-sg-1" {
  ipv6_cidr_blocks  = [local.ipv6_anywhere]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 80
  type              = "ingress"
}

resource "aws_security_group_rule" "ubuntu-web-sg-2" {
  # returns a single list item then leave it as-is and remove this TODO comment.
  cidr_blocks       = [local.ipv4_anywhere]
  from_port         = 2200
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 2200
  type              = "ingress"
  description       = "udacity ssh"
}

resource "aws_security_group_rule" "ubuntu-web-sg-3" {
  description       = "udacity ssh"
  ipv6_cidr_blocks  = [local.ipv6_anywhere]
  from_port         = 2200
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 2200
  type              = "ingress"
}

resource "aws_security_group_rule" "ubuntu-web-sg-4" {
  cidr_blocks       = ["98.215.88.119/32"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "ubuntu-web-sg-5" {
  cidr_blocks       = [local.ipv4_anywhere]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "ubuntu-web-sg-6" {
  ipv6_cidr_blocks  = [local.ipv6_anywhere]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "ubuntu-web-sg-7" {
  cidr_blocks       = [local.ipv4_anywhere]
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.ubuntu-web-sg.id
  to_port           = 0
  type              = "egress"
}

