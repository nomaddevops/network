output "s3_logging_bucket_name" {
  value = "${module.s3_logging_bucket.name}"
}

output "s3_logging_dns" {
  value = "${module.s3_logging_bucket.dns}"
}

output "s3_logging_arn" {
  value = "${module.s3_logging_bucket.arn}"
}

output "role_arn" {
  value = "${module.iam.role_arn}"
}

output "s3_policy" {
  value = module.s3_logging_bucket.policy
}