output "role_arn" {
  value = "${element(concat(aws_iam_role.iam_role.*.arn, list("")), 0)}"
}
