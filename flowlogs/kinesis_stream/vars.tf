/*
* KINESIS VARS DEFINITIONS
*/

variable "name" {
  description = "Generic name"
}

variable "environment" {
  description = "Environment of the plateform"
}

variable "service" {
  description = "Service name"
  default     = "logs"
}

variable "bucket_arn" {
  description = "ARN of the bucket to send logs"
}

variable "firehose_region" {
  description = "AWS Region where firehose is deployed"
}

variable "have_kinesis_stream" {
  default = false
}

variable "have_flowlogs" {
  default = false
}
