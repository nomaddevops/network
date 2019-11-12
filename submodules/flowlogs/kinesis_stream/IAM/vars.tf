/*
* IAM ROLE / POLICIES VARS DEFINITIONS
*/

variable "name" {}

variable "environment" {}

variable "have_kinesis_stream" {
  default = false
}

variable "have_flowlogs" {
  default = false
}
