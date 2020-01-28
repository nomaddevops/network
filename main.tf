/*
* VPC MODULE DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 15/06/2018 
*
*/

data "aws_region" "current" {
  name = var.region
}

data "aws_availability_zones" "availability_zones" {
}

resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = {
    Name = format(
      "%s-%s (%s)",
      title(var.plateform_name),
      "VPC",
      title(var.plateform_environment),
    )
    Environment       = title(var.plateform_environment)
    Delivered_Service = "Network"
    AWS_Service       = "VPC"
  }
}

module "subnets" {
  source = "./subnets"

  #CONDITIONS TO DEPLOY
  have_public_subnets  = var.have_public_subnets
  have_private_subnets = var.have_private_subnets
  have_nat_gateways    = var.have_nat_gateways
  is_multi_az          = var.is_multi_az

  #VARS IF DEPLOY

  ## ENV VARS
  plateform_name        = title(var.plateform_name)
  plateform_environment = title(var.plateform_environment)

  ## SUBMODULE VARS
  vpc_id                     = aws_vpc.vpc.id
  availability_zones         = [data.aws_availability_zones.availability_zones.names]
  cidr_block                 = aws_vpc.vpc.cidr_block
  virtual_private_gateway_id = var.have_vpn_connections == true ? list(module.vpn.virtual_private_gateway_id) : [] # if have vpn true must be set
}

module "flowlogs" {
  source = "./flowlogs"

  #CONDITIONS TO DEPLOY
  have_flowlogs       = var.have_flowlogs
  have_kinesis_stream = var.have_kinesis_stream
  have_logging_bucket = var.have_logging_bucket

  #VARS IF DEPLOY
  name                          = var.plateform_name
  environment                   = var.plateform_environment
  vpc_id                        = aws_vpc.vpc.id
  cwl_retention_in_days         = var.cwl_retention_in_days
  s3_expiration_enabled         = var.s3_expiration_enabled
  logs_expiration_standard      = var.logs_expiration_standard
  logs_expiration_onezone       = var.logs_expiration_onezone
  logs_expiration_glacier       = var.logs_expiration_glacier
  logs_complete_expiration_days = var.logs_complete_expiration_days
  region                        = var.region
}

module "vpc_peering" {
  source = "./vpc_peering"

  #CONDITIONS TO DEPLOY
  have_vpc_peering = var.have_vpc_peering

  #VARS IF DEPLOY
  plateform_name                             = title(var.plateform_name)
  plateform_environment                      = title(var.plateform_environment)
  peer_owner_ids                             = var.peer_owner_ids
  peer_vpc_ids                               = var.peer_vpc_ids
  peer_region                                = var.peer_region
  peer_friendly_name                         = var.peer_friendly_name
  vpc_id                                     = aws_vpc.vpc.id
  accepter_allow_remote_vpc_dns_resolution   = var.requester_allow_remote_vpc_dns_resolution
  accepter_allow_classic_link_to_remote_vpc  = var.requester_allow_classic_link_to_remote_vpc
  accepter_allow_vpc_to_remote_classic_link  = var.requester_allow_vpc_to_remote_classic_link
  requester_allow_remote_vpc_dns_resolution  = var.requester_allow_remote_vpc_dns_resolution
  requester_allow_classic_link_to_remote_vpc = var.requester_allow_classic_link_to_remote_vpc
  requester_allow_vpc_to_remote_classic_link = var.requester_allow_vpc_to_remote_classic_link
}

module "vpn" {
  source = "./vpn"

  #CONDITIONS TO DEPLOY
  have_vpn_connections = var.have_vpn_connections

  #VARS IF DEPLOY
  plateform_name        = title(var.plateform_name)
  plateform_environment = title(var.plateform_environment)

  client_name         = var.vpn_client_name
  client_vpn_endpoint = var.vpn_client_endpoint
  static_routes_only  = var.static_routes_only
  amazon_side_asn     = var.amazon_side_asn
  bgp_asn             = var.bgp_asn
  vpc_id              = aws_vpc.vpc.id
}

/*
module "nacl" {
  source = "./nacl"

  #CONDITIONS TO DEPLOY
  have_nacl = "${var.have_nacl}"

  #VARS IF DEPLOY
  Plateform_Name        = "${title(var.plateform_name)}"
  Plateform_Environment = "${title(var.plateform_environment)}"
}
*/
