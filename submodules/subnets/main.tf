/*
* SUBNETS MODULE DEFINITION
*
* Author       : Joffrey DUPIRE <joffrey.dupire@gmail.com> 
* Purpose      : A fulfully modelable VPC
* Last updated : 13/06/2018 
*
*/

#
# PUBLIC SUBNETS DEFINITION
#
resource "aws_subnet" "public_subnets" {
  count  = var.have_public_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_public_subnets == true && var.is_multi_az == false ? 1 : 0
  vpc_id = var.vpc_id
  
  cidr_block              = cidrsubnet(var.cidr_block, var.new_bits, (count.index+1))
  availability_zone       = element(flatten(var.availability_zones), count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name        = "${var.plateform_name}-${var.plateform_environment}-${tostring(element(flatten(var.availability_zones), count.index))}"
    Environment = var.plateform_environment
    Description = "Public Subnet for ${var.plateform_name} in ${tostring(element(flatten(var.availability_zones), count.index))}"
    Service     = "Subneting"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
}

#
# PUBLIC ROUTE TABLE DEFINITION
#

resource "aws_route_table" "public_rtb" {
  count            = var.have_public_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_public_subnets == true && var.is_multi_az == false ? 1 : 0
  vpc_id           = var.vpc_id
  propagating_vgws = var.virtual_private_gateway_id

  tags = {
    Name        = "${var.plateform_name}-${var.plateform_environment}-${tostring(element(flatten(var.availability_zones), count.index))}-rtb"
    Environment = var.plateform_environment
    Description = "Routing table for ${var.plateform_name} in ${tostring(element(flatten(var.availability_zones), count.index))}"
    Service     = "Routing"
  }
}

#
# PUBLIC DEFAULT ROUTE
#

resource "aws_route" "default_public_route" {
  count                  = var.have_public_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_public_subnets == true && var.is_multi_az == false ? 1 : 0 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw[0].id
  route_table_id         = element(aws_route_table.public_rtb.*.id,count.index)
}

#
# PUBLIC ROUTE TABLE ASSOCIATION
#

resource "aws_route_table_association" "public_rtb_association" {
  count          = var.have_public_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_public_subnets == true && var.is_multi_az == false ? 1 : 0
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_rtb.*.id, count.index)
}

#
# INTERNET GATEWAY DEFINITION
#

resource "aws_internet_gateway" "internet_gw" {
  count  = var.have_public_subnets == true ? 1 : 0 
  vpc_id = var.vpc_id

  tags = {
    Name        = var.plateform_name
    Environment = var.plateform_environment
    Service     = "Internet Access"
  }

  lifecycle {
    prevent_destroy = false
  }
}

#
# PRIVATE SUBNETS DEFINITION
#

resource "aws_subnet" "private_subnets" {
  count  = var.have_private_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_private_subnets == true && var.is_multi_az == false ? 1 : 0 
  vpc_id = var.vpc_id

  cidr_block        = cidrsubnet(var.cidr_block, var.new_bits, (count.index+1)*10)
  availability_zone = tostring(element(flatten(var.availability_zones), count.index))

  tags = {
    Name        = "${var.plateform_name}-${var.plateform_environment}-${tostring(element(flatten(var.availability_zones), count.index))}"
    Environment = var.plateform_environment
    Description = "Private Subnet for ${var.plateform_name} in ${tostring(element(flatten(var.availability_zones), count.index))}"
    Service     = "Subneting"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
}

#
# PRIVATE ROUTE TABLE DEFINITION
#

resource "aws_route_table" "private_rtb" {
  count            = var.have_private_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_private_subnets == true && var.is_multi_az == false ? 1 : 0 
  vpc_id           = var.vpc_id
  propagating_vgws = var.virtual_private_gateway_id

  tags = {
    Name        = "${var.plateform_name}-${var.plateform_environment}-${tostring(element(flatten(var.availability_zones), count.index))}-rtb"
    Environment = var.plateform_environment
    Description = "Routing table for ${var.plateform_name} in ${tostring(element(flatten(var.availability_zones), count.index))}"
    Service     = "Routing"
  }
}

#
# PRIVATE DEFAULT ROUTE
#

resource "aws_route" "default_private_route" {
  count                  = var.have_nat_gateways == true && var.have_private_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_nat_gateways == true && var.have_private_subnets == true && var.is_multi_az == false ? 1 : 0 
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)
  route_table_id         = element(aws_route_table.private_rtb.*.id, count.index)
}

#
# PRIVATE ROUTE TABLE ASSOCIATION
#

resource "aws_route_table_association" "private_rtb_association" {
  count          = var.have_private_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_private_subnets == true && var.is_multi_az == false ? 1 : 0 
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_rtb.*.id, count.index)
}

#
# NAT GATEWAYS DEFINITIONS
#

resource "aws_nat_gateway" "nat_gw" {
  count         = var.have_nat_gateways == true && var.have_private_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_nat_gateways == true && var.have_private_subnets == true && var.is_multi_az == false ? 1 : 0
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)

  tags = {
    Name        = "NATGW-${element(aws_subnet.public_subnets.*.availability_zone, count.index)}-${var.plateform_environment}"
    Description = "NAT Gateway for ${element(aws_subnet.public_subnets.*.availability_zone, count.index)}"
    Service     = "NAT"
  }
}

#
# EIP DEFINITIONS
#

resource "aws_eip" "nat_eip" {
  count = var.have_nat_gateways == true && var.have_private_subnets == true && var.is_multi_az == true ? length(flatten(var.availability_zones)) : var.have_nat_gateways == true && var.have_private_subnets == true && var.is_multi_az == false ? 1 : 0 
  vpc   = true
}
