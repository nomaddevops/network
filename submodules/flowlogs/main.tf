/*
* MODULE FLOWLOGS
*/

data "aws_region" "current" {}

module "iam" {
  source        = "./IAM"
  name          = var.name
  environment   = var.environment
  have_flowlogs = var.have_flowlogs
}

/*
* REJECTED NETWORK EVENTS
*/
resource "aws_cloudwatch_log_group" "vpc_rejected_lg" {
  count             = var.have_flowlogs == true ? 1 : 0
  name              = "${var.name}-${var.environment}-rejected-by-network"
  retention_in_days = var.cwl_retention_in_days

  tags = {
    Name        = "${var.name}-${var.environment}-rejected-by-network"
    Environment = var.environment
    Service     = "VPC Rejected FlowLogs"
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes  = ["name"]
  }
}

resource "aws_flow_log" "network_rejected_flow" {
  count          = var.have_flowlogs == true ? 1 : 0
  log_group_name = aws_cloudwatch_log_group.vpc_rejected_lg[count.index].name
  iam_role_arn   = module.iam.role_arn
  vpc_id         = var.vpc_id
  traffic_type   = "REJECT"
  depends_on     = ["aws_cloudwatch_log_group.vpc_rejected_lg"]
}

/*
* ACCEPTED NETWORK EVENTS
*/
resource "aws_cloudwatch_log_group" "vpc_accepted_lg" {
  count             = var.have_flowlogs == true ? 1 : 0
  name              = "${var.name}-${var.environment}-accepted-by-network"
  retention_in_days = var.cwl_retention_in_days

  tags = {
    Name        = "${var.name}-${var.environment}-accepted-by-network"
    Environment = var.environment
    Service     = "VPC Accepted FlowLogs"
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes  = ["name"]
  }
}

resource "aws_flow_log" "network_accepted_flow" {
  count          = var.have_flowlogs == true ? 1 : 0
  log_group_name = aws_cloudwatch_log_group.vpc_accepted_lg[count.index].name
  iam_role_arn   = module.iam.role_arn
  vpc_id         = var.vpc_id
  traffic_type   = "ACCEPT"
  depends_on     = ["aws_cloudwatch_log_group.vpc_accepted_lg"]
}

module "s3_logging_bucket" {
  source                        = "./s3_logs"
  have_kinesis_stream           = var.have_kinesis_stream
  have_flowlogs                 = var.have_flowlogs
  have_logging_bucket           = var.have_logging_bucket
  name                          = var.name
  environment                   = var.environment
  s3_expiration_enabled         = var.s3_expiration_enabled
  logs_expiration_standard      = var.logs_expiration_standard
  logs_expiration_onezone       = var.logs_expiration_onezone
  logs_expiration_glacier       = var.logs_expiration_glacier
  logs_complete_expiration_days = var.logs_complete_expiration_days
  region                        = var.region
}

module "data_stream" {
  source              = "./kinesis_stream"
  have_flowlogs       = var.have_flowlogs
  have_kinesis_stream = var.have_kinesis_stream
  name                = var.name
  environment         = var.environment
  bucket_arn          = module.s3_logging_bucket.arn
  firehose_region     = data.aws_region.current.name
}
