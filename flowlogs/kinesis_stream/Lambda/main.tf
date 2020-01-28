/*
* LAMBDA PROCESSING LOGS DEFINITIONS
*/

data "archive_file" "lambda_source" {
  count       = "${var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0}"
  type        = "zip"
  source_dir  = "${path.module}/templates/source_code"
  output_path = "${path.module}/templates/handler.zip"
}

resource "aws_lambda_function" "processing" {
  count         = "${var.have_kinesis_stream == true && var.have_flowlogs == true ? 1 : 0}"
  filename      = "${path.module}/templates/handler.zip"
  function_name = "${lower(var.name)}-${lower(var.environment)}-${lower(var.service)}-logs-processing"
  role          = "${var.lambda_role_arn}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  timeout       = "${var.timeout}"

  environment {
    variables = {
      FIREHOSE_STREAM_NAME = "${var.firehose_name}"
      FIREHOSE_REGION      = "${var.firehose_region}"
    }
  }

  source_code_hash = "${base64sha256("${path.module}/templates/handler.zip")}"
  depends_on       = [data.archive_file.lambda_source]
}
