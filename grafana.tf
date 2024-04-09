resource "aws_instance" "grafana" {
  ami           = "Ubuntu 20.04 ami"
  instance_type = "t2.micro"
  user_data = base64encode(file("grafana.sh"))
  key_name = "remote-kp"

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
    Name = "grafana-sg"
  }
}