/*
* IAM ROLE / POLICIES DEFINITIONS
*/

#
# KINESIS
#
resource "aws_iam_role" "kinesis_role" {
  count              = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  name               = "${var.name}-${var.environment}-kinesis"
  assume_role_policy = file("${path.module}/templates/policies/assume-kinesis.json")
}

resource "aws_iam_policy" "kinesis_policy" {
  count  = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  name   = "${var.name}-${var.environment}-kinesis-policy"
  policy = file("${path.module}/templates/policies/policy-kinesis.json")
}

resource "aws_iam_role_policy_attachment" "kinesis_attachment" {
  count      = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  role       = aws_iam_role.kinesis_role[count.index].name
  policy_arn = aws_iam_policy.kinesis_policy[count.index].arn
  depends_on = [aws_iam_role.kinesis_role, aws_iam_policy.kinesis_policy]
}

#
# LAMBDA
#

resource "aws_iam_role" "lambda_role" {
  count              = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  name               = "${var.name}-${var.environment}-lambda4kinesis"
  assume_role_policy = file("${path.module}/templates/policies/assume-lambda.json")
}

resource "aws_iam_policy" "lambda_policy" {
  count  = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  name   = "${var.name}-${var.environment}-lambda4kinesis-policy"
  policy = file("${path.module}/templates/policies/policy-lambda.json")
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  count      = var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0
  role       = aws_iam_role.lambda_role[count.index].name
  policy_arn = aws_iam_policy.lambda_policy[count.index].arn
  depends_on = [aws_iam_role.lambda_role, aws_iam_policy.lambda_policy]
}
