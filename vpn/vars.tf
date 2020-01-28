/*
* VPN MODULE VARS DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 13/06/2018 
*
*/

variable "plateform_name" {
  description = "Name of the plateform"
}

variable "plateform_environment" {
  description = "Plateform environment (test/prod/...)"
}

variable "have_vpn_connections" {
  description = "Should deploy vpn connections (true/false)"
  default     = false
}

variable "client_name" {
  type    = list(string)
  default = []
}

variable "vpc_id" {}

variable "client_vpn_endpoint" {
  type    = list(string)
  default = []
}

variable "static_routes_only" {
 description = "use static route"
 type = list(string)
 default = [] 
}

variable "amazon_side_asn" {
  default = 65000
}

variable "bgp_asn" {
  type = list(string)
  default = ["65000"]
}
