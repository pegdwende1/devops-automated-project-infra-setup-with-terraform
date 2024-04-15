provider "aws" {
  region  = "us-west-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = true
}
