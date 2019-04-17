#provider "aws" {
#    access_key = "${var.access_key}"
#    secret_key = "${var.secret_key}"
#    region     = "${var.region}"
#}

resource "aws_instance" "DC1" {
  ami           = "${var.DC_ami}"
  instance_type = "${var.DC_instance_type}"
  subnet_id      = "${aws_subnet.sandpit_subnet1.id}"
  associate_public_ip_address = "TRUE"
  tags {

    Name = "${var.First_DC_Name}"

  }
  
    user_data = "${file("./userdata.txt")}"
    vpc_security_group_ids = ["${aws_security_group.SG_ADSandpit.id}"]
}

resource "aws_security_group" "SG_ADSandpit" {
  name        = "${var.security_group_name}"
  description = "Allow all VPC traffic plus external RDP traffic"
  vpc_id      = "${aws_vpc.sandpitVPC.id}"

  tags {
    Name = "${var.security_group_name}"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "sandpitVPC" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_support = "FALSE"

  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_availability_zones" "AZs" {}

resource "aws_subnet" "sandpit_subnet1" {
  vpc_id = "${aws_vpc.sandpitVPC.id}"
  cidr_block = "${var.subnet1_cidr}"
  availability_zone_id = "${data.aws_availability_zones.AZs.zone_ids[0]}"
  tags {
    Name = "${var.subnet1_name}"
    }
}

resource "aws_subnet" "sandpit_subnet2" {
  vpc_id = "${aws_vpc.sandpitVPC.id}"
  cidr_block = "${var.subnet2_cidr}"
  availability_zone_id = "${data.aws_availability_zones.AZs.zone_ids[1]}"
  tags {
    Name = "${var.subnet2_name}"
  }
}

resource "aws_internet_gateway" "Sandpit_RDP_Gateway" {
  vpc_id = "${aws_vpc.sandpitVPC.id}"

  tags {
    Name = "${var.sandpit_internet_gateway_name}"
  }

}

data "aws_route_tables" "sandpit_route_table" {
  vpc_id = "${aws_vpc.sandpitVPC.id}"
}

resource "aws_route" "RDP_route" {
  route_table_id = "${data.aws_route_tables.sandpit_route_table.ids[0]}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.Sandpit_RDP_Gateway.id}"
}