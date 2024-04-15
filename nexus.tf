resource "aws_instance" "nexus" {
  ami           = "ami-050c61fa1bff25e5a"    #amazon linux 2 ami
  instance_type = "t2.medium"
  user_data = base64encode(file("nexus.sh"))
  # key_name = "remote_kp"

  tags = {
    Name = "NEXUS"
  }
}


resource "aws_security_group" "nex" {
  name   = "nexus-sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "nexus port"
    from_port   = 8081
    to_port     = 8081
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
    Name = "nexus-sg"
  }
}
