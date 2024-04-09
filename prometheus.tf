resource "aws_instance" "prometh" {
  ami           = " amazon linux 2 ami"
  instance_type = "t2.micro"
  user_data = base64encode(file("prometheus.sh"))
  key_name = "remote-kp"

  tags = {
    Name = "Prometheus"
  }
}


resource "aws_security_group" "prometheus" {
  name   = "promet"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "prometheus port"
    from_port   = 9090
    to_port     = 9090
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
    Name = "prometheus-sg"
  }
}