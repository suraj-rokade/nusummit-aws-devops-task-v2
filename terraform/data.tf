# data.tf

data "aws_vpc" "existing_vpc" {
  id = "vpc-0bafc3a4fda20d1c1"
}

data "aws_subnet" "existing_subnet" {
  id = "subnet-05913764580fd38fe"
}

data "aws_security_group" "existing_sg" {
  id = "sg-094b260a728550a4d"
}
