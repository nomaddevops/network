/*
* VARIABLES DEFINITIONS
*/

variable "name" {
  description = "Name of plateform"
  default     = "A_girl_has_no_name"
}

variable "environment" {
  description = "Environment of plateform"
  default     = "nowhere"
}

variable "cwl_retention_in_days" {
  description = "Retention in days of logs in log_group"
  default     = 7
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "have_flowlogs" {
  default     = false
  description = "Deploy flowlogs"
}

variable "have_kinesis_stream" {
  default     = false
  description = "Deploy kinesis data_stream for flowlogs"
}

variable "s3_expiration_enabled" {
  default     = false
  description = "Deploy a bucket to store all log events"
}

variable "logs_expiration_standard" {
  default = 15
}

variable "logs_expiration_onezone" {
  default = 30
}

variable "logs_expiration_glacier" {
  default = 60
}

variable "logs_complete_expiration_days" {
  default = 90
}

variable "have_logging_bucket" {
  description = "Force deployment of logging bucket even if there is no kinesis"
  default     = false
}


variable "region" {
  
}