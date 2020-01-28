/*
* VPC VARS DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable VPC
*
*/

#
# MAIN VARS
#
variable "region" {
  description = "AWS Region to use"
}

variable "plateform_name" {
  description = "Name of the plateform"
}

variable "plateform_environment" {
  description = "Plateform environment (test/prod/...)"
}

variable "cidr_block" {
  description = "Enter the cidr block for your VPC"
}

variable "instance_tenancy" {
  description = "Default instance tenancy for EC2 launched inside the VPC"
  default     = "default"
}

variable "enable_classiclink" {
  default = false
}

variable "enable_classiclink_dns_support" {
  default = false
}

variable "enable_dns_hostnames" {
  default = false
}

variable "enable_dns_support" {
  default = false
}

variable "assign_generated_ipv6_cidr_block" {
  default = false
}

#
# CONDITIONALS VARS
#

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

variable "have_nacl" {
  description = "Should deploy nacl (true/false)"
  default     = false
}

variable "is_multi_az" {
  description = "Use all az of the current region (true/false)"
  default     = false
}

## LOGGING VARS

variable "have_flowlogs" {
  description = "Enable FlowLogs (true/false)"
  default     = false
}

variable "have_kinesis_stream" {
  description = "Enable Kinesis Data Stream for Flowlogs (true/false)"
  default     = false
}

variable "s3_expiration_enabled" {
  description = "Enable logs expiration in logging bucket"
  default     = false
}

variable "logs_expiration_standard" {
  description = "Number of days before change S3 Storage Class to Standard IA"
  default     = 15
}

variable "logs_expiration_onezone" {
  description = "Number of days before change S3 Storage Class to One Zone IA"
  default     = 30
}

variable "logs_expiration_glacier" {
  description = "Number of days before change S3 Storage Class to Glacier"
  default     = 60
}

variable "logs_complete_expiration_days" {
  description = "Number of days object finally expire in S3"
  default     = 90
}

variable "cwl_retention_in_days" {
  description = "Retention in days for FlowLogs"
  default     = 90
}

variable "have_logging_bucket" {
  default     = false
  description = "Force deployment of S3 logging bucket even if kinesis isn't deployed"
}

## VPN CONNECTIONS VARS
variable "have_vpn_connections" {
  description = "Should deploy vpn connections (true/false)"
  default     = false
}

variable "vpn_client_name" {
  type        = list(string)
  default     = []
  description = "All the name for each vpn client"
}

variable "vpn_client_endpoint" {
  type        = list(string)
  default     = []
  description = "All the public IP for each vpn client"
}

variable "static_routes_only" {
  description = "use static route"
  type        = list(string)
  default     = []
}

variable "amazon_side_asn" {
  default = 65000
}

variable "bgp_asn" {
  type    = list(string)
  default = ["64999"]
}

## VPC PEERING VARS
variable "have_vpc_peering" {
  description = "Should deploy a VPC peering (true/false)"
  default     = false
}

variable "peer_owner_ids" {
  type        = list(string)
  description = "List of AWS Account ID of the peer"
  default     = []
}

variable "peer_vpc_ids" {
  type        = list(string)
  description = "List of all peer vpc id"
  default     = []
}

variable "peer_region" {
  type        = list(string)
  description = "List of region for each vpc peer"
  default     = []
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

variable "peer_friendly_name" {
  type        = list(string)
  description = "List of peer name"
  default     = []
}

