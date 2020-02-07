data "template_file" "policy" {
  template = "${file("${path.module}/templates/policy.json")}"

  vars = {
    bucket = "${lower(var.name)}-${lower(var.service)}-${lower(var.environment)}"
    accountid = lookup(var.accountid, var.region)
  }
}

resource "aws_s3_bucket" "logs" {
  count  = var.have_flowlogs == true && var.have_kinesis_stream == true ? 1 : var.have_logging_bucket == true ? 1 : 0
  bucket = "${lower(var.name)}-${lower(var.service)}-${lower(var.environment)}"

  lifecycle {
    prevent_destroy = false
    ignore_changes = ["bucket"]
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled = var.s3_expiration_enabled

    transition {
      days          = var.logs_expiration_standard
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.logs_expiration_onezone
      storage_class = "ONEZONE_IA"
    }

    transition {
      days          = var.logs_expiration_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.logs_complete_expiration_days
    }
  }

  versioning {
    enabled = false
  }

  tags = {
    Name        = "${var.name}-${var.service}-${var.environment}"
    Environment = var.environment
    Service     = var.service
  }

  policy = data.template_file.policy.rendered
}
