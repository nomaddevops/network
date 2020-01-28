resource "aws_iam_role" "iam_role" {
  count                 = var.have_flowlogs == true ? 1 : 0
  name                  = "${var.name}-${var.environment}-flowlogs-role"
  assume_role_policy    = file("${path.module}/templates/assume-role.json")
  force_detach_policies = true
  description           = "Role for VPC FlowLogs"
}

resource "aws_iam_policy" "iam_policy" {
  count       = var.have_flowlogs == true ? 1 : 0
  name        = "${var.name}-${var.environment}-flowlogs-policy"
  description = "Policy to allow vpc to write in cloudwatch loggroup"
  policy      = file("${path.module}/templates/policy-flowlogs.json")
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  count      = var.have_flowlogs == true ? 1 : 0
  role       = aws_iam_role.iam_role[count.index].name
  policy_arn = aws_iam_policy.iam_policy[count.index].arn
  depends_on = [aws_iam_role.iam_role, aws_iam_policy.iam_policy]
}
