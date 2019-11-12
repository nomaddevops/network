/*
* VPC PEERING MODULE DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@gmail.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 01/11/2018 
*
*/

resource "aws_vpc_peering_connection" "vpc_peering" {
  count         = var.have_vpc_peering == true ? length(var.peer_owner_ids) : 0
  peer_owner_id = element(var.peer_owner_ids, count.index)
  peer_vpc_id   = element(var.peer_vpc_ids, count.index)
  peer_region   = element(var.peer_region, count.index)
  vpc_id        = var.vpc_id
  #auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution  = var.accepter_allow_remote_vpc_dns_resolution
    allow_classic_link_to_remote_vpc = var.accepter_allow_classic_link_to_remote_vpc
    allow_vpc_to_remote_classic_link = var.accepter_allow_vpc_to_remote_classic_link
  }

  requester {
    allow_remote_vpc_dns_resolution  = var.requester_allow_remote_vpc_dns_resolution
    allow_classic_link_to_remote_vpc = var.requester_allow_classic_link_to_remote_vpc
    allow_vpc_to_remote_classic_link = var.requester_allow_vpc_to_remote_classic_link
  }

  tags = {
    Name        = "${title(var.plateform_name)}-${title(element(var.peer_friendly_name,count.index))}-${title(var.plateform_environment)}"
    Environment = title(var.plateform_environment)
    Service     = title(var.service)
  }
}
