resource "aws_instance" "instance_public"{
  ami           = "ami-00beae93a2d981137"
  instance_type = "t2.micro"
  key_name      = "Yogi"
  security_groups = [aws_security_group.sg.id]
  subnet_id     = aws_subnet.subnet_1.id
  associate_public_ip_address = "true"
  count = 1
  tags = {
         aws = "My_instance_1"
     }
}

resource "aws_instance" "instance_private"{
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  key_name      = "Yogi"
  security_groups = [aws_security_group.sg.id]
  subnet_id     = aws_subnet.subnet_2.id
  associate_public_ip_address = "false"
  count = 1
  tags = {
         aws = "My_instance_2"
     }
}

resource "aws_security_group" "sg" {
  name        = "Mysecuritygroup"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "My_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_1_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "ingress_2_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ingress_3_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "egress_1_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

