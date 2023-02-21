# access keys

variable "region" {
  description = "Chosen region for deployment"
  type = string
  sensitive = true
}

variable "access_key" {
  description = "General access key for AWS account."
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "General secret key for AWS account."
  type        = string
  sensitive   = true
}

#customer site resources

variable "public_ip" {
    description = "Public IP"
    type = string
    sensitive = true
}

#Tags

variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
  sensitive   = true
}

variable "proj_prefix" {
  description = "Project Prefix"
  type        = string
  sensitive   = true
}

variable "team" {
  description = "Team"
  type        = string
  sensitive   = true
}

# ec2

variable "ami" {
  description = "ami code"
  type        = string
  sensitive   = true
}

variable "bastion_priv_ip" {
  description = "bastion host private ip"
  type        = string
  sensitive   = true
}

variable "keyname" {
  description = "keyname for ec2"
  type        = string
  sensitive   = true
}

variable "ec2_eip_cidr" {
  description = "ec2 elastic ip cidr"
  type        = string
  sensitive   = true
}