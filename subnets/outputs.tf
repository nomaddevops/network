/*
* SUBNETS MODULE OUTPUTED RESOURCES
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable subnets
* Last Updated : 04/07/2018
*/

output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gw.*.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gw.*.id
}

output "nat_gateway_ips" {
  value = aws_eip.nat_eip.*.public_ip
}

output "public_rtb" {
  value = aws_route_table.public_rtb.*.id
}

output "private_rtb" {
  value = aws_route_table.private_rtb.*.id
}
