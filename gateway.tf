resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.east_1_vpc.id

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-igw"
        Role: "${var.env_prefix}-igw"
        Team: "team-${var.team}"
    
    }
}

resource "aws_customer_gateway" "cust_gate" {
  bgp_asn    = 65000
  ip_address = var.public_ip
  type       = "ipsec.1"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-cust_gate"
        Role: "${var.env_prefix}-cust_gate"
        Team: "team-${var.team}"
    
    }
}