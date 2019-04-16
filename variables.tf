# Global variables

variable "region" {
    # The AWS region in which to deploy the AD sandpit environment
    default = "eu-west-1"
}

# VPC variables

variable "vpc_name" {
    # The name of the VPC for the environment
    default = "Sandpit_vpc"
}

variable "vpc_cidr_block" {
    # The address range for the new VPC
    default = "172.100.0.0/16"
}

# Subnet variables

variable "subnet1_cidr" {
    # The first subnet/AZ cidr range
    default = "172.100.0.0/24"
}

variable "subnet2_cidr" {
    # The second subnet/AZ cidr range
    default = "172.100.1.0/24"
}

variable "subnet1_name" {
    # Name of the first subnet
    default = "Sandpit_subnet_1"
}

variable "subnet2_name" {
    # Name of the first subnet
    default = "Sandpit_subnet_2"
}

# Internet gateway variables

variable "sandpit_internet_gateway_name" {
    # Name for the internet gateway to associate with the VPC for RDP access
    default = "Sandpit_Gateway_For_RDP"
}

# Security group variables

variable "security_group_name" {
    # The name of the security group for DCs
    default = "sandpit_sg"
}


# EC2 instance variables

variable "DC_ami" {
    # This is the ami ID for the AWS marketplace image used for the domain controller
    default = "ami-0e19770d1a2173385"
}

variable "DC_instance_type" {
    # This is the EC2 instance type for the domain controller
    default = "t3.micro"
}

variable "First_DC_Name" {
    # This is the name given to the domain controller
    default = "ADSandpitDC1"
}