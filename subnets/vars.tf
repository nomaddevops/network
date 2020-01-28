/*
* SUBNETS MODULE VARS DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable subnets
* Last Updated : 13/06/2018
*/

variable "plateform_name" {
  description = "Name of the plateform"
}

variable "plateform_environment" {
  description = "Plateform environment (test/prod/...)"
}

variable "have_public_subnets" {
  description = "Should deploy public subnet, deploy NAT Gateways too (true/false)"
  default     = false
}

variable "have_private_subnets" {
  description = "Should deploy private subnet (true/false)"
  default     = false
}

variable "have_nat_gateways" {
  description = "Should allow private subnet to access internet through public subnets (true/false)"
  default     = false
}

variable "cidr_block" {
  description = "Enter the cidr block for your VPC"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use in the current region"
}

variable "virtual_private_gateway_id" {
  type = list(string)
  description = "ID of the virtual private gateway for vpn connections"
}

variable "is_multi_az" {
  description = "Use all az of the current region (true/false)"
  default     = false
}

variable "new_bits" {
  default     = 8
  description = "Default bits to calculate CIDR subnets"
}
