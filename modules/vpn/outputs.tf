/*
* VPN MODULE OUTPUTED RESOURCES
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Last updated : 15/06/2018 
*
*/

output "virtual_private_gateway_id" {
  value = element(concat(aws_vpn_gateway.vpn_gw.*.id, list("")), 0)
  description = "Return a list of vpn gateway ids"
}
