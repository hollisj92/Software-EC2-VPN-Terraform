resource "aws_vpc" "east_1_vpc" {
  cidr_block = "172.25.0.0/16"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-east_1_vpc"
        Role: "${var.env_prefix}-east_1_vpc"
        Team: "team-${var.team}"
    
    }
}

resource "aws_subnet" "east_1a_aws_subnet" {
  vpc_id     = aws_vpc.east_1_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  depends_on = [aws_internet_gateway.igw]

 tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-east_1a_aws_subnet"
        Role: "${var.env_prefix}-east_1a_aws_subnet"
        Team: "team-${var.team}"
    
    }
}

resource "aws_subnet" "east_1b_aws_subnet" {
  vpc_id     = aws_vpc.east_1_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-east_1b_aws_subnet"
        Role: "${var.env_prefix}-east_1b_aws_subnet"
        Team: "team-${var.team}"
    
    }
}

resource "aws_route_table" "east_1_routetable" {
  vpc_id = aws_vpc.east_1_vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-east_1_routetable"
        Role: "${var.env_prefix}-east_1_routetable"
        Team: "team-${var.team}"
    
    }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.east_1b_aws_subnet.id
  route_table_id = aws_route_table.east_1_routetable.id
}