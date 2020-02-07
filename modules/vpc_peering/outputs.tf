/*
* VPC PEERING OUTPUTED RESOURCES
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 13/06/2018 
*
*/

output "id" {
  value = element(concat(aws_vpc_peering_connection.vpc_peering.*.id, list("")), 0)
  description = "Return a list of vpc peering ids"
}

output "accept_status" {
  value = element(concat(aws_vpc_peering_connection.vpc_peering.*.accept_status, list("")), 0)
  description = "Return a list of peering status"
}
