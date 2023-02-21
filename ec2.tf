resource "aws_instance" "bastion_vpn_ec2" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${var.keyname}"
  subnet_id = aws_subnet.east_1a_aws_subnet.id
  vpc_security_group_ids = [aws_security_group.bastion_vpn_secgroup.id]

  

  user_data = <<-EOF
              #!/bin/bash
              yum install -y amazon-linux-extras
              amazon-linux-extras install -y epel
              yum install -y openvpn
              EOF

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-bastion_vpn_ec2"
        Role: "${var.env_prefix}-bastion_vpn_ec2"
        Team: "team-${var.team}"
    
    }
}

resource "aws_eip" "ec2_eip_cidr" {
  vpc = true

  instance                  = aws_instance.bastion_vpn_ec2.id
  associate_with_private_ip = "${var.bastion_priv_ip}"
  depends_on                = [aws_internet_gateway.igw]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_launch_template" "ubuntu_template" {
  name_prefix = "ubuntu-launch-template"
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-ubuntu_template"
        Role: "${var.env_prefix}-ubuntu_template"
        Team: "team-${var.team}"
    
    }
  }
}

resource "aws_autoscaling_group" "LAB_ASG" {
  name                 = "example-autoscaling-group"
  vpc_zone_identifier  = [aws_subnet.east_1b_aws_subnet.id]
  launch_template {
    id      = aws_launch_template.ubuntu_template.id
    version = "$Latest"
  }
  min_size             = 1
  max_size             = 2
}

resource "aws_autoscaling_policy" "LAB_ASP" {
  name                   = "example-autoscaling-policy"
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.LAB_ASG.name

  scaling_adjustment     = 1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
}

