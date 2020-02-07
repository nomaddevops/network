/*
* IAM ROLE / POLICIES OUTPUTED VARS
*/

output "kinesis_role_arn" {
  value = "${element(concat(aws_iam_role.kinesis_role.*.arn, list("")), 0)}"
}

output "lambda_role_arn" {
  value = "${element(concat(aws_iam_role.lambda_role.*.arn, list("")), 0)}"
}

output "kinesis_role_id" {
  value = "${element(concat(aws_iam_role.kinesis_role.*.id, list("")), 0)}"
}

output "lambda_role_id" {
  value = "${element(concat(aws_iam_role.lambda_role.*.id, list("")), 0)}"
}
