/*
* NETWORK ACL VARIABLES DEFINITIONS
*
* Author       : Joffrey DUPIRE <joffrey.dupire@gmail.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 13/06/2018 
*
*/

variable "have_nacl" {
  description = "Deploy AWS Network ACL"
  default = false
}

variable "vpc_id" {
  description = "ID of the vpc to apply nacl"
  default = ""
}

variable "subnet_ids" {
  type = "list"
  description = "List of subnet IDs to apply Network acl"
  default = []
}


