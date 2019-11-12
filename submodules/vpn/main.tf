/*
* VPN MODULE DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@gmail.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 13/06/2018 
*
*/

#
# VPN GATEWAY DEFINITION
#
resource "aws_vpn_gateway" "vpn_gw" {
  count  = var.have_vpn_connections == true ? 1 : 0 
  vpc_id = var.vpc_id
  amazon_side_asn = var.amazon_side_asn

  tags = {
    Name        = "${var.plateform_name}-vgw"
    Environment = var.plateform_environment
    Service     = "Virtual Private Gateway"
  }

  lifecycle {
    prevent_destroy = true
  }
}

#
# CUSTOMERS GATEWAY DEFINITION
#
resource "aws_customer_gateway" "customer_gateway" {
  count      = var.have_vpn_connections == true ? length(var.client_name) : 0 
  bgp_asn    = element(var.bgp_asn,count.index)
  type       = "ipsec.1"
  ip_address = tostring(element(flatten(var.client_vpn_endpoint),count.index))

  tags = {
    Name        = "${var.plateform_name}-${tostring(element(flatten(var.client_name), count.index))}-cgw"
    Environment = var.plateform_environment
    Service     = "Customer Gateway"
    Description = "CGW for ${tostring(element(flatten(var.client_name),count.index))}"
  }
}

#
# VPN CONNECTION DEFINITION
#

resource "aws_vpn_connection" "client_vpn_connection" {
  count               = var.have_vpn_connections == true ? length(var.client_name) : 0 
  vpn_gateway_id      = element(aws_vpn_gateway.vpn_gw.*.id, count.index)
  customer_gateway_id = element(aws_customer_gateway.customer_gateway.*.id,count.index)
  type                = "ipsec.1"
  static_routes_only  = element(var.static_routes_only, count.index)

  tags = {
    Name        = "${var.plateform_name}-${tostring(element(flatten(var.client_name),count.index))}-vpn-connection"
    Environment = var.plateform_environment
    Service     = "VPN"
    Description = "VPN connection for ${tostring(element(flatten(var.client_name),count.index))}"
  }

  lifecycle {
    ignore_changes = ["vpn_gateway_id", "customer_gateway_id"]
  }
}
