/*
* KINESIS DEFINITIONS
* Purpose : Stream Cloudwatch Logs to Kinesis to S3   
*/

#
# IAM
#

module "iam_role" {
  source              = "./IAM"
  name                = var.name
  environment         = var.environment
  have_kinesis_stream = var.have_kinesis_stream
  have_flowlogs       = var.have_flowlogs
}

#
# LAMBDA PROCESSING
#
module "lamdba_processing" {
  source              = "./Lambda"
  name                = var.name
  environment         = var.environment
  runtime             = "python2.7"
  firehose_name       = "${var.name}-${var.environment}-${var.service}-firehose"
  firehose_region     = var.firehose_region
  lambda_role_arn     = module.iam_role.lambda_role_arn
  have_kinesis_stream = var.have_kinesis_stream
  have_flowlogs       = var.have_flowlogs
}

#
# DATA STREAM
#
resource "aws_kinesis_firehose_delivery_stream" "log_stream" {
  count       = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  name        = "${var.name}-${var.environment}-${var.service}-firehose"
  destination = "s3"

  s3_configuration {
    bucket_arn         = var.bucket_arn
    role_arn           = module.iam_role.kinesis_role_arn
    prefix             = "Network_logs"
    compression_format = "GZIP"
  }
}
