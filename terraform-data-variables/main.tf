resource "aws_instance" "public" {
  ami                         = "ami-01edba92f9036f76e"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = "tag-key-pair"
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "${var.name}-ec2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "tag-terraform-security-group"
  description = "Allow SSH inbound"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = "tag-terraform-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}