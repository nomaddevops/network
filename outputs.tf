/*
* VPC OUTPUTED RESOURCES
*
* Author       : Joffrey DUPIRE <joffrey.dupire@ynov.com> 
* Purpose      : A fulfully modelable VPC
*
*/

# OUTPUT FROM MAIN
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# OUTPUT FROM SUBNETS MODULE
output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.subnets.internet_gateway_id
}

output "nat_gateway_ids" {
  value = module.subnets.nat_gateway_ids
}

output "nat_gateway_ips" {
  value = module.subnets.nat_gateway_ips
}

output "public_rtb" {
  value = module.subnets.public_rtb
}

output "private_rtb" {
  value = module.subnets.private_rtb
}

# OUTPUT FROM FLOWLOGS
output "s3_logging_bucket_name" {
  value = module.flowlogs.s3_logging_bucket_name
}

output "s3_logging_bucket_dns" {
  value = module.flowlogs.s3_logging_dns
}

output "s3_logging_bucket_arn" {
  value = module.flowlogs.s3_logging_arn
}

output "s3_policy" {
  value = module.flowlogs.s3_policy
}

# OUTPUT FROM VPC_PEERING
output "vpc_peering_id" {
  value = module.vpc_peering.id
}

output "vpc_peering_accept_status" {
  value = module.vpc_peering.accept_status
}

