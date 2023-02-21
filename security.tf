resource "aws_security_group" "bastion_vpn_secgroup" {
  name_prefix = "bastion_vpn_secgroup-"
  vpc_id = aws_vpc.east_1_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_customer_gateway.cust_gate.ip_address]
  }

  ingress {
    from_port = 1194
    to_port = 1194
    protocol = "udp"
    cidr_blocks = [aws_customer_gateway.cust_gate.ip_address]
  }
}

resource "aws_security_group" "private_cluster_ec2" {
  name_prefix = "cluster-"
  vpc_id = aws_vpc.east_1_vpc.id


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ec2_eip_cidr]
  }
}