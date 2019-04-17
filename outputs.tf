output "DC__Public_IP" {
    value = "${aws_instance.DC1.public_ip}"
}

output "DC_Private_IP" {
    value = "${aws_instance.DC1.private_ip}"
}

output "sandpit_subnet1_id" {
    value = "${aws_subnet.sandpit_subnet1.id}"
}

output "sandpit_subnet2_id" {
    value = "${aws_subnet.sandpit_subnet2.id}"
}

output "vpc_cidr_block" {
    value = "${var.vpc_cidr_block}"
}

output "vpc_id" {
    value = "${aws_vpc.sandpitVPC.id}"
}