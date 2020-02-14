data "template_file" "artifact_repository_bucket_policy" {
    template = "${file("${path.root}/policy/s3_bucket_secure_transport.json.tpl")}"
    vars = {
        resource = "${aws_s3_bucket.artifact_repository_bucket.id}"
  }   
}

resource "aws_s3_bucket" "artifact_repository_bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name               = "${var.bucket_name}"
    controlled_by      = "terraform"
    dataclassification = "Internal"
    purpose            = "Bucket for Systems Manager artifacts"
  }
  
}

resource "aws_s3_bucket_policy" "artifact_repository_bucket_policy" {
    bucket = aws_s3_bucket.artifact_repository_bucket.id
    policy = data.template_file.artifact_repository_bucket_policy.rendered
}