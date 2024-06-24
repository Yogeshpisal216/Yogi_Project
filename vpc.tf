resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Aws = "My_Vpc"
    }
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "us-east-1a"

  tags = {
    Name = "My_subnet_1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "My_IGW"
  }
}

resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "My_Route_Table_1"
  }
}

resource "aws_main_route_table_association" "route_association_ig" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.route_table_1.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table_1.id
}



