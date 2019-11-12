output "name" {
  value = "${element(concat(aws_s3_bucket.logs.*.id, list("")), 0)}"
}

output "dns" {
  value = "${element(concat(aws_s3_bucket.logs.*.bucket_domain_name, list("")), 0)}"
}

output "arn" {
  value = "${element(concat(aws_s3_bucket.logs.*.arn, list("")), 0)}"
}

output "policy" {
  value = data.template_file.policy.rendered
}
