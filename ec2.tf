resource "aws_instance" "myec2" {
  ami = data.aws_ami.ami_id.id
  instance_type = local.instance_type
}

data "aws_ami" "ami_id" {
   most_recent = true
   owners = ["amazon"] 
}

locals {
  instance_type = "t2.large"
  app_port=80
}

resource "aws_security_group" "sg" {
    name = "myec2-sg"

    ingress {
        description = "Allow Inbound from secret application"
        from_port = local.app_port
        to_port = local.app_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "sgoutput" {
  value = aws_security_group.sg.arn
}