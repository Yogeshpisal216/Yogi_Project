resource "aws_instance" "instance"{
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  key_name      = "My_key"
  security_groups = [aws_security_group.sg.id]
  subnet_id     = aws_subnet.subnet_1.id
}

resource "aws_security_group" "sg" {
  name        = "Mysecuritygroup"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "My_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = aws_vpc.vpc.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv6         = aws_vpc.vpc.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

