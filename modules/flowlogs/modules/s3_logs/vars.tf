variable "name" {}

variable "environment" {}

variable "s3_expiration_enabled" {
  default = false
}

variable "have_flowlogs" {}
variable "have_kinesis_stream" {}

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

variable "service" {
  default = "log-storage"
}

variable "have_logging_bucket" {
  default = false
}

variable "accountid" {
  type = "map"
  default = {
    eu-west-1 = "156460612806"
    eu-west-2 = "652711504416"
    eu-west-3 = "009996457667"
  }
}

variable "region" {
  
}