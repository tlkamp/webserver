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
  ami_in_use = "ami-0653e888ec96eab9b"
}

output "server-up-to-date" {
  value = "${data.aws_ami.ubuntu-ami.image_id == local.ami_in_use}"
}

resource "aws_instance" "ubuntu-web" {
  ami           = "${local.ami_in_use}"
  instance_type = "t2.micro"
  key_name      = "udacity-webserver"

  tags {
    Name = "Ubuntu Web"
  }
}

resource "aws_eip" "ubuntu-web-static-ip" {
  instance = "${aws_instance.ubuntu-web.id}"
  vpc      = true
}
