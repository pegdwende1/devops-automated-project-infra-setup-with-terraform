resource "aws_instance" "deploy" {
  ami           = "amazon linux 2 ami"
  instance_type = "t2.micro"
  user_data = base64decode(file("deployment-servers.sh"))
  key_name = "remote-kp"
  count = 3

  tags = {
    Name = " "
  }
}


resource "aws_security_group" "deployment" {
  name   = "deployment"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "service port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "node exp"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "deployment-sg"
  }
}