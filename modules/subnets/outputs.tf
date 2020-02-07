/*
* SUBNETS MODULE OUTPUTED RESOURCES
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable subnets
* Last Updated : 04/07/2018
*/

output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
  description = "Return a list of public subnets ids"
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
  description = "Return a list of private subnets ids"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gw.*.id
  description = "Return a list of internet gateway ids"
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gw.*.id
  description = "Return a list of nat gateways ids"
}

output "nat_gateway_ips" {
  value = aws_eip.nat_eip.*.public_ip
  description = "Return a list of nat gateways IP Addresses"
}

output "public_rtb" {
  value = aws_route_table.public_rtb.*.id
  description = "Return a list of public route tables ids"
}

output "private_rtb" {
  value = aws_route_table.private_rtb.*.id
  description = "Return a list of private route tables ids"
}
