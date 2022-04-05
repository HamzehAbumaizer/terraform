resource "aws_instance" "web" {
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  }

resource "aws_eip" "lb" {
    vpc      = true
  }

resource "aws_eip_association" "eip_assoc" {
  instance_id   = 	aws_instance.web.id
  allocation_id =   aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "terraform-security-group"

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}"/32]
  }
  }
