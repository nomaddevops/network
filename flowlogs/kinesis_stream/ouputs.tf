output "kinesis_role_arn" {
  value = module.iam_role.kinesis_role_arn
}

output "lambda_role_arn" {
  value = module.iam_role.lambda_role_arn
}

output "kinesis_role_id" {
  value = module.iam_role.kinesis_role_id
}

output "lambda_role_id" {
  value = module.iam_role.lambda_role_id
}
