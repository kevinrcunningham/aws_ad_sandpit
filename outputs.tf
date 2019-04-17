output "DC__Public_IP" {
    value = "${aws_instance.DC1.public_ip}"
}

output "DC_Private_IP" {
    value = "${aws_instance.DC1.private_ip}"
}