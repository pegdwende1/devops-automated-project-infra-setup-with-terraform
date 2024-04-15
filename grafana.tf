resource "aws_instance" "grafana" {
  ami           = "ami-02bfcfbf6fc7e8ce4"     #Ubuntu 20.04 ami
  instance_type = "t2.micro"
  user_data = base64encode(file("grafana.sh"))
  key_name = "remote_kp"

  tags = {
    Name = "grafana"
  }
}


resource "aws_security_group" "graf" {
  name   = "grafana"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "grafana port"
    from_port   = 3000
    to_port     = 3000
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


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "grafana-sg"
  }
}
