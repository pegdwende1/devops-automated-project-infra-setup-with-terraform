resource "aws_instance" "sonarQ" {
  ami           = "ami-02bfcfbf6fc7e8ce4"    #ubuntu 20.04
  instance_type = "t2.medium"
  user_data = base64encode(file("sonarQube.sh"))

  tags = {
    Name = "Sonarqube"
  }
}


resource "aws_security_group" "sonar" {
  name   = "sonar"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "sonarqube port"
    from_port   = 9000
    to_port     = 9000
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
    Name = "sonarqube-sg"
  }
}
