/*
* VPC PEERING VARIABLES DEFINITION
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

variable "service" {
  description = "service deployed"
  default     = "VPC Peering"
}

variable "have_vpc_peering" {
  description = "Should deploy an vpc peering (true/false)"
  default     = false
}

variable "peer_owner_ids" {
  type        = "list"
  description = "List of AWS Account ID of the peer"
  default     = []
}

variable "peer_vpc_ids" {
  type        = "list"
  description = "List of all peer vpc id"
  default     = []
}

variable "peer_region" {
  type        = "list"
  description = "List of region for each vpc peer"
  default     = []
}

variable "peer_friendly_name" {
  type        = "list"
  description = "List of peer name"
  default     = []
}

variable "vpc_id" {
  description = "VPC id of the account owner"
}

variable "accepter_allow_remote_vpc_dns_resolution" {
  description = "Allow vpc accepter dns resolution"
  default     = false
}

variable "accepter_allow_classic_link_to_remote_vpc" {
  description = "Allow vpc accepter classic link on remote"
  default     = false
}

variable "accepter_allow_vpc_to_remote_classic_link" {
  description = "Allow vpc accepter classic link from current vpc"
  default     = false
}

variable "requester_allow_remote_vpc_dns_resolution" {
  description = "Allow vpc requester dns resolution"
  default     = false
}

variable "requester_allow_classic_link_to_remote_vpc" {
  description = "Allow vpc requester classic link on remote"
  default     = false
}

variable "requester_allow_vpc_to_remote_classic_link" {
  description = "Allow vpc requester classic link from current vpc"
  default     = false
}
