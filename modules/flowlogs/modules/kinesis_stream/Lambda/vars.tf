/*
* LAMBDA PROCESSING VARS DEFINITIONS
*/

variable "name" {
  description = "Generic name"
}

variable "environment" {
  description = "Environment of the plateform"
}

variable "service" {
  description = "Executed Service"
  default     = "Lambda"
}

variable "handler" {
  description = "Lambda handler"
  default     = "main.lambda_handler"
}

variable "runtime" {
  description = "Lambda runtime"
}

variable "timeout" {
  description = "timeout for lambda"
  default     = 60
}

variable "firehose_name" {
  description = "FireHose stream name"
}

variable "firehose_region" {
  description = "AWS Region where firehose is deployed"
}

variable "lambda_role_arn" {
  description = "Lambda role arn"
}

variable "have_kinesis_stream" {
  default = false
}

variable "have_flowlogs" {
  default = false
}
