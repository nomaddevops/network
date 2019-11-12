/*
* VPN MODULE VARS DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 13/06/2018 
*
*/

variable "module_version" {
  description = "Current version of the module"
  default     = "v0.0.1"
}

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
  type    = "list"
  default = []
}

variable "vpc_id" {}

variable "client_vpn_endpoint" {
  type    = "list"
  default = []
}

variable "static_routes_only" {
 description = "use static route"
 type = "list"
 default = [] 
}

variable "amazon_side_asn" {
  default = 65000
}

variable "bgp_asn" {
  type = "list"
  default = ["65000"]
}
